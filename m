From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 12 Nov 2012 15:14:02 +0100
Subject: [PATCHv6 0/2] Add support for the OLED in the CFA10036
In-Reply-To: <1351674774-2891-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1351674774-2891-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <50A1042A.2090405@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ping?

Le 31/10/2012 10:12, Maxime Ripard a ?crit :
> Hi everyone,
> 
> This patchset adds support for the solomon SSD1307 OLED controller present
> in the CFA-10036 board.
> 
> It first adds the framebuffer driver for this controller, and then the
> needed bits to enable it in the cfa10036 dts.
> 
> Considering that the driver has been around since almost three months now, and
> I have not received any comments on the framebuffer part, I'd very much like it
> to be included in 3.8 if possible.
> 
> Thanks,
> Maxime
> 
> Changes from v5:
>   * Fixed bogus reset code
> 
> Maxime Ripard (2):
>   video: Add support for the Solomon SSD1307 OLED Controller
>   ARM: dts: mxs: add oled support for the cfa-10036
> 
>  .../devicetree/bindings/video/ssd1307fb.txt        |   24 ++
>  arch/arm/boot/dts/imx28-cfa10036.dts               |   19 +
>  drivers/video/Kconfig                              |   13 +
>  drivers/video/Makefile                             |    1 +
>  drivers/video/ssd1307fb.c                          |  407 ++++++++++++++++++++
>  5 files changed, 464 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/video/ssd1307fb.txt
>  create mode 100644 drivers/video/ssd1307fb.c
> 


-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
