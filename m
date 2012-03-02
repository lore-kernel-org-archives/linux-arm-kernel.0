From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 2 Mar 2012 14:30:14 -0800
Subject: [PATCH v3 0/5] ARM: Tegra: cleanup patches from Arnd Bergmann
In-Reply-To: <1330727075-10974-1-git-send-email-alan@signal11.us>
References: <1330721884-8495-1-git-send-email-alan@signal11.us>
 <1330727075-10974-1-git-send-email-alan@signal11.us>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17BE861AAB@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alan Ott wrote at Friday, March 02, 2012 3:25 PM:
> Version 3 of the patch set.
> 
> Changes:
> 	* change of logic (and commit message change) for
> 	  "select USB_ULPI if USB is selected"
> 	* dropped THUMB2 patch
> 
> Arnd Bergmann (5):
>   ARM: tegra: do not hide dma declarations
>   ARM: tegra: select CPU_FREQ_TABLE
>   ARM: tegra: build localtimer support only when needed
>   ARM: tegra: select USB_ULPI if USB is selected
>   ARM: tegra: export usb phy symbols

The series,

Acked-by: Stephen Warren <swarren@nvidia.com>

Thanks Arnd and Alan for cleaning Tegra up!

-- 
nvpublic
