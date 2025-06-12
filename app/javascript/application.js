// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "chartkick"
import "Chart.bundle"
import "./navbar"

document.addEventListener('DOMContentLoaded', function() {
  // Mobile menu toggle
  const mobileMenuButton = document.getElementById('mobile-menu-button');
  const mobileMenu = document.getElementById('mobile-menu');
  
  if (mobileMenuButton && mobileMenu) {
    mobileMenuButton.addEventListener('click', function() {
      const expanded = this.getAttribute('aria-expanded') === 'true';
      this.setAttribute('aria-expanded', !expanded);
      mobileMenu.classList.toggle('hidden');
      
      // Toggle icon
      const icons = this.querySelectorAll('svg');
      icons.forEach(icon => icon.classList.toggle('hidden'));
    });
  }
  
  // User dropdown menu
  const userMenuButton = document.getElementById('user-menu');
  if (userMenuButton) {
    const userMenu = userMenuButton.nextElementSibling;
    
    userMenuButton.addEventListener('click', function() {
      const expanded = this.getAttribute('aria-expanded') === 'true';
      this.setAttribute('aria-expanded', !expanded);
      userMenu.classList.toggle('hidden');
    });
  }
  
  // Close menus when clicking outside
  document.addEventListener('click', function(event) {
    if (mobileMenuButton && !mobileMenuButton.contains(event.target) && mobileMenu && !mobileMenu.contains(event.target)) {
      mobileMenuButton.setAttribute('aria-expanded', 'false');
      mobileMenu.classList.add('hidden');
    }
    
    if (userMenuButton && !userMenuButton.contains(event.target)) {
      userMenuButton.setAttribute('aria-expanded', 'false');
      if (userMenuButton.nextElementSibling) {
        userMenuButton.nextElementSibling.classList.add('hidden');
      }
    }
  });
});