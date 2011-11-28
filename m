From: wayne.tams@gmail.com (Wayne Tams)
Date: Mon, 28 Nov 2011 09:38:00 +0000
Subject: 2.6.38 port not booting on i.MX53 SoM
Message-ID: <CAN=k24ncTxDMXZzO1ef_+ETFiiqJZxtYSEOAKz3DiwCO8UKwcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I have a feeling that this might be a very common question and with
multiple answers, but I am running out of options, so here it goes.

I have been working with i.MX53 SoM with a 2.6.35 BSP, I am trying to
dump the SoMs BSP in  favour for Freescale's latest kernel 2.6.38
(http://opensource.freescale.com/git?p=imx/linux-2.6-imx.git;a=summary).

Using the 2.6.35 kernel as reference I have been trying to configure
the 2.6.38 kernel to match as well as modifying and adding board and
platform information.

The kernel compiles fine but when I come to load the image the kernel
gets stuck at "Uncompressing Linux... done, booting the kernel."

Are there any obvious causes for this freeze?
Have I overlooked a source tree modification?
Have I maybe gone about this all wrong?

Best regards

Wayne
