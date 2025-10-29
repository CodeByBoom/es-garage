<template>
  <div class="garage-app" v-if="isVisible">
    
    <!-- Invisible drag area for mouse rotation/zoom -->
    <div class="move"></div>

    <!-- Header -->
    <div class="header">
      <svg width="118.625rem" height="18.75rem" viewBox="0 0 1898 300" fill="none" xmlns="http://www.w3.org/2000/svg">
        <text transform="translate(400 13)" fill="white" fill-opacity="0.25" xml:space="preserve" style="white-space: pre" font-family="Oswald" font-size="217.379" font-weight="bold" letter-spacing="0em"><tspan x="0" y="165.475">GARAGE</tspan></text>
        <defs>
          <filter id="filter0_bd_392_1520" x="1294.87" y="-15.135" width="602.27" height="314.27" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
            <feFlood flood-opacity="0" result="BackgroundImageFix"/>
            <feGaussianBlur in="BackgroundImageFix" stdDeviation="10"/>
            <feComposite in2="SourceAlpha" operator="in" result="effect1_backgroundBlur_392_1520"/>
            <feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
            <feOffset dy="24"/>
            <feGaussianBlur stdDeviation="56.5675"/>
            <feComposite in2="hardAlpha" operator="out"/>
            <feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.16 0"/>
            <feBlend mode="normal" in2="effect1_backgroundBlur_392_1520" result="effect2_dropShadow_392_1520"/>
            <feBlend mode="normal" in="SourceGraphic" in2="effect2_dropShadow_392_1520" result="shape"/>
          </filter>
          <filter id="filter1_d_392_1520" x="106.28" y="55.2725" width="360.288" height="121.728" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
            <feFlood flood-opacity="0" result="BackgroundImageFix"/>
            <feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
            <feOffset/>
            <feGaussianBlur stdDeviation="15"/>
            <feComposite in2="hardAlpha" operator="out"/>
            <feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.64 0"/>
            <feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow_392_1520"/>
            <feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow_392_1520" result="shape"/>
          </filter>
          <linearGradient id="paint0_linear_392_1520" x1="1397.94" y1="51.4788" x2="1420.01" y2="183.467" gradientUnits="userSpaceOnUse">
            <stop stop-color="#1B87B5" stop-opacity="0.35"/>
            <stop offset="1" stop-opacity="0.15"/>
          </linearGradient>
          <radialGradient id="paint1_radial_392_1520" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(1596 118) rotate(-165.951) scale(245.969 90.1893)">
            <stop stop-color="white"/>
            <stop offset="1" stop-color="white" stop-opacity="0"/>
          </radialGradient>
          <radialGradient id="paint2_radial_392_1520" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(1596 118) rotate(11.1801) scale(228.741 63.2246)">
            <stop stop-color="#35302E"/>
            <stop offset="1" stop-color="#E3CD4B" stop-opacity="0"/>
          </radialGradient>
          <radialGradient id="paint3_radial_392_1520" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(1596 118) rotate(167.462) scale(209.959 66.503)">
            <stop stop-color="white"/>
            <stop offset="1" stop-color="#151515" stop-opacity="0"/>
          </radialGradient>
          <linearGradient id="paint4_linear_392_1520" x1="611.5" y1="86" x2="611.5" y2="142" gradientUnits="userSpaceOnUse">
            <stop stop-color="#6100FF"/>
            <stop offset="1" stop-color="#0094FF"/>
          </linearGradient>
        </defs>
      </svg>
    </div>

    <!-- Stats Bars (Right side) -->
    <div class="bar">
      <div class="contain" v-for="feature in features" :key="feature.label">
        <li>{{ feature.label }}</li>
        <div class="load" :style="{ width: feature.value + '%' }"></div>
      </div>
    </div>

    <!-- Vehicle Cards (Bottom) -->
    <div class="vehicle-scroll-hint">
      <span>← → ARROW KEYS TO SCROLL</span>
    </div>
    <div class="container" ref="vehicleContainer">
      <div class="car" @click="selectVehicle(vehicle)" v-for="vehicle in filteredVehicles" :key="vehicle.VIN">
        <div class="border">
          <div class="details">
            <p class="title">{{ vehicle.title }}</p>
          </div>
          <div class="favorite">
            <span class="icon">⭐</span> ADD TO FAVORITES
          </div>
          <img :src="getImagePath(vehicle.vehicle)" :alt="vehicle.vehicle" class="car-image" @error="handleImageError" />
        </div>
      </div>
    </div>

    <!-- Details Panel (Right side) -->
    <div class="features" v-if="isVisible">
      <svg width="38.25rem" height="40.9375rem" viewBox="0 0 612 655" fill="none" xmlns="http://www.w3.org/2000/svg">
        <g filter="url(#filter0_bd_392_1540)">
          <g clip-path="url(#clip0_392_1540)">
            <rect x="497" y="91" width="425" height="382" rx="15" transform="rotate(90 497 91)" fill="url(#paint0_linear_392_1540)" fill-opacity="0.2" shape-rendering="crispEdges"/>
            <text fill="white" xml:space="preserve" style="white-space: pre" font-family="Oswald" font-size="20" font-weight="600" letter-spacing="0em"><tspan x="149" y="144.508">INFO ABOUT YOUR CAR:</tspan></text>
            <text fill="white" xml:space="preserve" style="white-space: pre" font-family="Oswald" font-size="18" font-weight="600" letter-spacing="0em"><tspan x="149" y="195.34">NAME:</tspan></text>
            <text fill="white" xml:space="preserve" style="white-space: pre" font-family="Oswald" text-anchor="end" font-size="18" font-weight="600" letter-spacing="0em"><tspan x="460" y="195.34">{{ truncateText(selectedVehicle?.title || '', 18) }}</tspan></text>
            <text fill="white" xml:space="preserve" style="white-space: pre" font-family="Oswald" font-size="18" font-weight="600" letter-spacing="0em"><tspan x="149" y="230.34">PLATE:</tspan></text>
            <text fill="white" xml:space="preserve" style="white-space: pre" font-family="Oswald" text-anchor="end" font-size="18" font-weight="600" letter-spacing="0em"><tspan x="460" y="230.34">{{ truncateText(selectedVehicle?.plate || '', 10) }}</tspan></text>
            <text fill="white" xml:space="preserve" style="white-space: pre" font-family="Oswald" font-size="18" font-weight="600" letter-spacing="0em"><tspan x="149" y="265.34">VIN:</tspan></text>
            <text fill="white" xml:space="preserve" style="white-space: pre" font-family="Oswald" text-anchor="end" font-size="12" font-weight="600" letter-spacing="-0.02em"><tspan x="460" y="265.34">{{ selectedVehicle?.VIN || '' }}</tspan></text>
          </g>
          <rect x="497.5" y="90.5" width="426" height="383" rx="15.5" transform="rotate(90 497.5 90.5)" stroke="url(#paint5_radial_392_1540)" stroke-opacity="0.43" shape-rendering="crispEdges"/>
          <rect x="497.5" y="90.5" width="426" height="383" rx="15.5" transform="rotate(90 497.5 90.5)" stroke="url(#paint6_radial_392_1540)" stroke-opacity="0.23" shape-rendering="crispEdges"/>
          <rect x="497.5" y="90.5" width="426" height="383" rx="15.5" transform="rotate(90 497.5 90.5)" stroke="url(#paint7_radial_392_1540)" shape-rendering="crispEdges"/>
          <rect x="497.5" y="90.5" width="426" height="383" rx="15.5" transform="rotate(90 497.5 90.5)" stroke="#95A3C9" stroke-opacity="0.29" shape-rendering="crispEdges"/>
        </g>
        <defs>
          <filter id="filter0_bd_392_1540" x="-281.972" y="-305.972" width="1175.94" height="1218.94" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
            <feFlood flood-opacity="0" result="BackgroundImageFix"/>
            <feGaussianBlur in="BackgroundImageFix" stdDeviation="197.986"/>
            <feComposite in2="SourceAlpha" operator="in" result="effect1_backgroundBlur_392_1540"/>
            <feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
            <feOffset dy="24"/>
            <feGaussianBlur stdDeviation="56.5675"/>
            <feComposite in2="hardAlpha" operator="out"/>
            <feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.16 0"/>
            <feBlend mode="normal" in2="effect1_backgroundBlur_392_1540" result="effect2_dropShadow_392_1540"/>
            <feBlend mode="normal" in="SourceGraphic" in2="effect2_dropShadow_392_1540" result="shape"/>
          </filter>
          <linearGradient id="paint0_linear_392_1540" x1="484.432" y1="-13.4779" x2="760.444" y2="408.768" gradientUnits="userSpaceOnUse">
            <stop stop-color="#1B87B5" stop-opacity="0.35"/>
            <stop offset="1" stop-opacity="0.15"/>
          </linearGradient>
          <radialGradient id="paint5_radial_392_1540" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(709.5 282) rotate(-135.634) scale(379.292 295.219)">
            <stop stop-color="white"/>
            <stop offset="1" stop-color="white" stop-opacity="0"/>
          </radialGradient>
          <radialGradient id="paint6_radial_392_1540" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(709.5 282) rotate(37.6882) scale(322.235 226.537)">
            <stop stop-color="#35302E"/>
            <stop offset="1" stop-color="#E3CD4B" stop-opacity="0"/>
          </radialGradient>
          <radialGradient id="paint7_radial_392_1540" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(709.5 282) rotate(139) scale(308.598 228.384)">
            <stop stop-color="white"/>
            <stop offset="1" stop-color="#151515" stop-opacity="0"/>
          </radialGradient>
          <clipPath id="clip0_392_1540">
            <rect x="497" y="91" width="425" height="382" rx="15" transform="rotate(90 497 91)" fill="white"/>
          </clipPath>
        </defs>
      </svg>
    </div>

    <!-- Buttons (Right side) -->
    <div class="button">
      <svg width="23.875rem" height="9.5rem" viewBox="0 0 382 152" fill="none" xmlns="http://www.w3.org/2000/svg">
        <rect @click="spawnVehicle" y="76" width="382" height="60" rx="8" fill="url(#paint0_linear_471_1800)"/>
        <text @click="spawnVehicle" fill="white" xml:space="preserve" style="white-space: pre; cursor: pointer;" font-family="Oswald" font-size="18" font-weight="600" letter-spacing="0em"><tspan x="100" y="114">USE THIS VEHICLE</tspan></text>
        <rect @click="closeGarage" width="382" height="60" rx="8" fill="url(#paint1_linear_471_1800)" fill-opacity="0.1"/>
        <text @click="closeGarage" fill="white" fill-opacity="0.5" xml:space="preserve" style="white-space: pre; cursor: pointer;" font-family="Oswald" font-size="18" font-weight="600" letter-spacing="0em">
          <tspan x="55" y="38">VEHICLE REMAINS PARKED</tspan>
        </text>
        <defs>
          <linearGradient id="paint0_linear_471_1800" x1="28.8983" y1="156.333" x2="286.667" y2="147.327" gradientUnits="userSpaceOnUse">
            <stop stop-color="#6100FF"/>
            <stop offset="1" stop-color="#8000FF"/>
          </linearGradient>
          <linearGradient id="paint1_linear_471_1800" x1="28.8983" y1="51.3333" x2="286.667" y2="42.3274" gradientUnits="userSpaceOnUse">
            <stop stop-color="white"/>
            <stop offset="1" stop-color="white"/>
          </linearGradient>
        </defs>
      </svg>
    </div>

  </div>
</template>

<script setup>
import { ref, computed, onMounted, onUnmounted } from 'vue'
import { mockGarageData, mockVehicleStats } from './mock-data.js'

const isVisible = ref(false)
const vehicles = ref([])
const selectedVehicle = ref(null)
const vehicleContainer = ref(null)
const features = ref([
  { label: 'SPEED', value: 0 },
  { label: 'FUEL', value: 0 },
  { label: 'DURABILITY', value: 0 },
])
// Detect if we're in a browser (for development) or FiveM
// In FiveM, GetParentResourceName exists as a native function
const isBrowser = typeof window.GetParentResourceName === 'undefined'



const filteredVehicles = computed(() => {
  return vehicles.value
})

function truncateText(text, maxLength) {
  if (!text) return ''
  if (text.length <= maxLength) return text
  return text.substring(0, maxLength - 3) + '...'
}

function getImagePath(vehicleModel) {
  // In browser dev mode, images are served from /car/ via publicDir
  // In FiveM, images are at ../assets/car/
  if (isBrowser) {
    return `/car/${vehicleModel}.png`
  }
  return `../assets/car/${vehicleModel}.png`
}

function handleMessage(event) {
  const item = event.data
  
  if (item.data === 'GARAGE') {
    isVisible.value = true
    
    if (item.car && item.car.length > 0) {
      vehicles.value = item.car.map(v => ({
        ...v,
        title: v.title || v.model,
        location: v.location || 'GARAGE'
      }))
      
      // Auto-select first vehicle
      selectVehicle(vehicles.value[0])
    } else {
      vehicles.value = []
    }
  } else if (item.data === 'CLOSE') {
    // Just hide the UI, don't call closeGarage() to avoid infinite loop
    isVisible.value = false
    selectedVehicle.value = null
  }
}

function selectVehicle(vehicle) {
  if (!vehicle) return
  selectedVehicle.value = vehicle
  
  // Use mock data in browser
  if (isBrowser) {
    features.value = [
      { label: 'SPEED', value: Math.floor(mockVehicleStats.Speed || 0) },
      { label: 'FUEL', value: Math.floor(mockVehicleStats.Fuel || 0) },
      { label: 'DURABILITY', value: Math.floor(mockVehicleStats.Traction || 0) },
    ]
    return
  }
  
  // Request vehicle stats from Lua in FiveM
  const xhr = new XMLHttpRequest()
  xhr.open('POST', `https://${GetParentResourceName()}/VehicleInfo`, true)
  xhr.setRequestHeader('Content-Type', 'application/json')
  xhr.onload = function() {
    if (xhr.status === 200) {
      const data = JSON.parse(xhr.responseText)
      features.value = [
        { label: 'SPEED', value: Math.floor(data.Speed || 0) },
        { label: 'FUEL', value: Math.floor(data.Fuel || 0) },
        { label: 'DURABILITY', value: Math.floor(data.Traction || 0) },
      ]
    }
  }
  xhr.send(JSON.stringify({ data: vehicle }))
}

function spawnVehicle() {
  if (!selectedVehicle.value) return
  
  if (isBrowser) {
    closeGarage()
    return
  }
  
  const xhr = new XMLHttpRequest()
  xhr.open('POST', `https://${GetParentResourceName()}/SpawnVehicle`, true)
  xhr.setRequestHeader('Content-Type', 'application/json')
  xhr.send(JSON.stringify(selectedVehicle.value))
  
  closeGarage()
}

function closeGarage() {
  isVisible.value = false
  selectedVehicle.value = null
  
  if (isBrowser) {
    return
  }
  
  const xhr = new XMLHttpRequest()
  xhr.open('POST', `https://${GetParentResourceName()}/exit`, true)
  xhr.setRequestHeader('Content-Type', 'application/json')
  xhr.send(JSON.stringify({}))
}

function handleImageError(e) {
  e.target.style.opacity = '0.3'
}

function handleKeyPress(e) {
  if (e.which == 27 || e.key === 'Escape') {
    closeGarage()
  }
}

function GetParentResourceName() {
  return 'es-garage'
}

function handleContainerKeyPress(e) {
  if (!vehicleContainer.value || !isVisible.value) return
  
  const scrollAmount = 300
  if (e.key === 'ArrowLeft') {
    e.preventDefault()
    vehicleContainer.value.scrollLeft -= scrollAmount
  } else if (e.key === 'ArrowRight') {
    e.preventDefault()
    vehicleContainer.value.scrollLeft += scrollAmount
  }
}

onMounted(() => {
  window.addEventListener('message', handleMessage)
  document.addEventListener('keyup', handleKeyPress)
  document.addEventListener('keydown', handleContainerKeyPress)
  
  // Camera rotation - EXACTLY like the reference implementation
  let holding = false
  let direction = ""
  let oldx = 0
  
  document.addEventListener('mousedown', (e) => holding = true)
  document.addEventListener('mouseup', (e) => holding = false)
  
  document.addEventListener('mousemove', function(e) {
    if (e.pageX < oldx) { direction = "left" } 
    else if (e.pageX > oldx) { direction = "right" }
    oldx = e.pageX
    
    if (isBrowser) return
    
    if (direction == "left" && holding) {
      if (e.target.classList.contains("move")) {
        const xhr = new XMLHttpRequest()
        xhr.open('POST', `https://${GetParentResourceName()}/rotateright`, true)
        xhr.setRequestHeader('Content-Type', 'application/json')
        xhr.send(JSON.stringify({}))
      }
    }
    if (direction == "right" && holding) {
      if (e.target.classList.contains("move")) {
        const xhr = new XMLHttpRequest()
        xhr.open('POST', `https://${GetParentResourceName()}/rotateleft`, true)
        xhr.setRequestHeader('Content-Type', 'application/json')
        xhr.send(JSON.stringify({}))
      }
    }
  })
  
  document.addEventListener('wheel', function(e) {
    if (!e.target.classList.contains("move") || isBrowser) return
    
    const endpoint = e.deltaY < 0 ? 'zoomIn' : 'zoomOut'
    const xhr = new XMLHttpRequest()
    xhr.open('POST', `https://${GetParentResourceName()}/${endpoint}`, true)
    xhr.setRequestHeader('Content-Type', 'application/json')
    xhr.send(JSON.stringify({}))
  })
  
  // Auto-load mock data ONLY in browser (not in FiveM)
  if (isBrowser) {
    console.log('[BROWSER MODE] Auto-loading mock garage data for development...')
    setTimeout(() => {
      handleMessage({ data: mockGarageData })
    }, 500)
  }
})

onUnmounted(() => {
  window.removeEventListener('message', handleMessage)
  document.removeEventListener('keyup', handleKeyPress)
  document.removeEventListener('keydown', handleContainerKeyPress)
})
</script>
