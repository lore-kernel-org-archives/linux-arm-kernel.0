From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 24 Apr 2016 23:51:11 +0200
Subject: [GIT PULL] omap device tree changes for v4.7 merge window, part 1
In-Reply-To: <20160422223829.GO5995@atomide.com>
References: <20160422223829.GO5995@atomide.com>
Message-ID: <13923085.h5mVoITCv7@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 22 April 2016 15:38:29 Tony Lindgren wrote:
> First set of device tree changes for omaps for v4.7 merge window:
> 
> - Two sets of name and unit address check fixes for dts files.
> 
> - DMA, McASP, and timer and regulator related dts changes for dra7
> 
> - Add more devices for Nokia N9/N950
> 
> - Initial support for am335x ICEv2
> 
> - Initial support for am572x-IDK
> 
> - Pinctrl changes for am335x-baltos-ir5221
> 
> - Initial support for Amazon Kindle Fire (first generation)
> 
> - A series of changes to add GPIO controller support for the
>   GPMC driver. The driver changes will be merged separately.
> 
> - Support for am43xx clkout1
> 
> - Pinctrl and RTC changes for am335x-chili
> 
> - Add support for dra72-evm rev C (SR2.0)
> 

Pulled into next/dt, thanks!

	Arnd
