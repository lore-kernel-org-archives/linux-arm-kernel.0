From: lauri.hintsala@bluegiga.com (Lauri Hintsala)
Date: Thu, 12 Jan 2012 08:33:20 +0200
Subject: mxs-auart serial driver DMA support?
Message-ID: <4F0E7EB0.2060906@bluegiga.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Any plans to add DMA support for mxs-auart serial driver? I noticed it 
is impossible to archive full 3.25 Mbs speed with current one.

There is DMA supported driver on freescale's git tree:
http://opensource.freescale.com/git?p=imx/linux-2.6-imx.git;a=blob;f=drivers/serial/mxs-auart.c;hb=imx_2.6.35_11.09.01

As I understood porting DMA support from freescale's driver is not 
trivial because MXS DMA implementation has been changed to mainline version.

Regards,
Lauri Hintsala
