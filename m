From: tony@atomide.com (Tony Lindgren)
Date: Thu, 22 Dec 2011 10:22:56 -0800
Subject: [PATCH 03/10] arm: omap2: fix omap3 touchbook kconfig warning
In-Reply-To: <1324341747-5922-4-git-send-email-felipe.contreras@gmail.com>
References: <1324341747-5922-1-git-send-email-felipe.contreras@gmail.com>
 <1324341747-5922-4-git-send-email-felipe.contreras@gmail.com>
Message-ID: <20111222182256.GO24444@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Contreras <felipe.contreras@gmail.com> [111219 16:11]:
> warning: (MACH_OMAP3_TOUCHBOOK && DRM_RADEON_KMS && DRM_I915 && STUB_POULSBO && FB_BACKLIGHT && USB_APPLEDISPLAY && FB_OLPC_DCON && ASUS_LAPTOP && SONY_LAPTOP && THINKPAD_ACPI && EEEPC_LAPTOP && ACPI_ASUS && ACPI_CMPC && SAMSUNG_Q10) selects BACKLIGHT_CLASS_DEVICE which has unmet direct dependencies (HAS_IOMEM && BACKLIGHT_LCD_SUPPORT)
> 
> A lot of boards need BACKLIGHT_CLASS_DEVICE for the framebuffers to
> work, but it's not *needed* for the device itself. It might be nice to
> enable it by default somewhoe if graphics stuff is enabled, but that's
> another story.

Thanks applying into fixes-non-critical-part3.

Tony
