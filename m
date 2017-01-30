From: olof@lixom.net (Olof Johansson)
Date: Sun, 29 Jan 2017 17:05:37 -0800
Subject: [GIT PULL 3/4] TI DaVinci DT updates for v4.11
In-Reply-To: <20170124130641.28264-3-nsekhar@ti.com>
References: <20170124130641.28264-1-nsekhar@ti.com>
 <20170124130641.28264-3-nsekhar@ti.com>
Message-ID: <20170130010537.GS3133@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 24, 2017 at 06:36:40PM +0530, Sekhar Nori wrote:
> The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:
> 
>   Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.11/dt
> 
> for you to fetch changes up to 4302a38ef6f1ebdbdec886bcc7b2d27654e50aea:
> 
>   ARM: dts: Add LEGO MINDSTORMS EV3 dts (2017-01-20 17:17:29 +0530)
> 
> ----------------------------------------------------------------
> Device tree updates for DaVinci DA850
> 
> * GPIO keys on DA850 LCDK
> * LCDC display on DA850 LCDK
> * USB OHCI on DA850 LCDK
> * VPIF (video input) on DA850 LCDK
> * Add a DA8xx specific compatible for UARTs
> * Introduce support for Lego Mindstorms EV3
> 
> ----------------------------------------------------------------
> Axel Haslam (2):
>       ARM: dts: da850: Add usb device node
>       ARM: dts: da850-lcdk: Enable ohci for omapl138 lcdk
> 
> Bartosz Golaszewski (4):
>       ARM: dts: da850-lcdk: add gpio-keys
>       ARM: dts: da850: rename the display node label
>       ARM: dts: da850-lcdk: add the vga-bridge node
>       ARM: dts: da850: specify the maximum pixel clock rate for tilcdc
> 
> David Lechner (5):
>       ARM: dts: da850: Add ti,da830-uart compatible for serial ports
>       dt-bindings: Add vendor prefix for LEGO
>       dt-bindings: Add LEGO MINDSTORMS EV3 compatible specification
>       dt-bindings: add "microchip,24c128" compatible string
>       ARM: dts: Add LEGO MINDSTORMS EV3 dts
> 
> Kevin Hilman (3):
>       ARM: dts: davinci: da850: VPIF: add node and muxing
>       ARM: dts: davinci: da850-evm: enable VPIF
>       ARM: dts: davinci: da850-lcdk: enable VPIF

Merged, thanks!


-Olof
