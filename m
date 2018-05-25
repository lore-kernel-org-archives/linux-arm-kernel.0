From: olof@lixom.net (Olof Johansson)
Date: Fri, 25 May 2018 04:59:23 -0700
Subject: [GIT PULL 2/3] DaVinci device-tree updates for v4.18
In-Reply-To: <20180517130845.863-2-nsekhar@ti.com>
References: <20180517130845.863-1-nsekhar@ti.com>
 <20180517130845.863-2-nsekhar@ti.com>
Message-ID: <20180525115923.l2ypbw2dap6dmjyo@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2018 at 06:38:44PM +0530, Sekhar Nori wrote:
> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
> 
>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.18/dt
> 
> for you to fetch changes up to fe9d2a40d995dc1da042a4fcd7813239d063554d:
> 
>   ARM: dts: da850-evm: add WP and CD to MMC (2018-05-16 16:36:51 +0530)
> 
> ----------------------------------------------------------------
> DaVinci device-tree updates for v4.18
> 
> * DA850 EVM gains USB support, SD card write-protect, card detect
>   and some clean-up
> * Support for gpio-ranges makes using gpios from DT much easier
> * Lego EV3 clean-up
> 
> ----------------------------------------------------------------
> Adam Ford (3):
>       ARM: dts: da850-evm: Enable usb_phy, usb0 and usb1
>       ARM: dts: da850-evm: use phandles to extend nodes
>       ARM: dts: da850-evm: add WP and CD to MMC
> 
> David Lechner (2):
>       ARM: dts: da850: use gpio-ranges
>       ARM: dts: da850-lego-ev3: remove unnecessary gpio-keys properties

Merged, thanks!

-Olof
