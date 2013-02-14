From: sameo@linux.intel.com (Samuel Ortiz)
Date: Thu, 14 Feb 2013 13:26:20 +0100
Subject: [GIT PULL] mfd: OMAP USB Host cleanup for 3.9
In-Reply-To: <511CD26F.4080909@ti.com>
References: <511CD215.8080005@ti.com>
 <511CD26F.4080909@ti.com>
Message-ID: <20130214122620.GF20996@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Roger

On Thu, Feb 14, 2013 at 02:02:55PM +0200, Roger Quadros wrote:
> Hi Samuel,
> 
> This contains the MFD portion of the OMAP USB Host cleanup series for 3.9.
> It is based on 3.8-rc6 + usbhost17-common that I've sent earlier.
> 
> The first patch touches drivers/usb/ehci-omap.c and is pending ACK from Greg KH.
> The reason it needs to go through MFD tree is that it depends on the platform
> header changes as the MFD drivers.
> 
> Please pull. Thanks.
> 
> The following changes since commit 7f07863ec60f7d3dbeec5aff881ea074db3925ed:
> 
>   ARM: OMAP: Consolidate OMAP USB-HS platform data (part 1/3) (2013-02-13 13:22:34 +0200)
> 
> are available in the git repository at:
>   git://github.com/rogerq/linux.git usbhost17-for-mfd
Pulled as well, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
