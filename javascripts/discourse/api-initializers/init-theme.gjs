import { apiInitializer } from 'discourse/lib/api';

export default apiInitializer((api) => {
    // Function to parse user field mappings from settings
    function parseFieldMappings(mappingsString) {
        if (!mappingsString || typeof mappingsString !== 'string') {
            return [];
        }
        
        // Split the string by pipes to get individual mappings
        const mappingStrings = mappingsString.split('|');
        
        const parsedMappings = mappingStrings.map(mapping => {
            const parts = mapping.split(',').map(part => part.trim());
            
            if (parts.length === 3) {
                return {
                    fieldKey: parts[0],
                    fieldValue: parts[1],
                    cssClass: parts[2]
                };
            }
            return null;
        }).filter(mapping => mapping !== null);
        
        return parsedMappings;
    }
    
    // Function to add CSS classes based on user fields
    function addUserFieldClasses() {
        const currentUser = api.getCurrentUser();
        if (!currentUser || !currentUser.custom_fields) {
            return;
        }
        
        // Try to get the custom_field_mappings setting
        let fieldMappingsString;
        if (settings.custom_field_mappings) {
            fieldMappingsString = settings.custom_field_mappings;
        } else {
            return;
        }
        
        const mappings = parseFieldMappings(fieldMappingsString);
        
        if (mappings.length === 0) {
            return;
        }
        
        mappings.forEach(mapping => {
            const fieldValue = currentUser.custom_fields[mapping.fieldKey];
            
            if (fieldValue) {
                // Handle multiselect fields (arrays)
                if (Array.isArray(fieldValue)) {
                    if (fieldValue.includes(mapping.fieldValue)) {
                        document.body.classList.add(mapping.cssClass);
                    }
                }
                // Handle boolean and dropdown fields (strings)
                else if (fieldValue === mapping.fieldValue) {
                    document.body.classList.add(mapping.cssClass);
                }
            }
        });
    }
    
    // Run when page changes
    api.onPageChange(() => {
        addUserFieldClasses();
    });
    
    // Also run on initial page load
    $(document).ready(() => {
        addUserFieldClasses();
    });
});
