From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 30 May 2013 16:51:59 +0800
Subject: [PATCH v6 09/10] ASoC: fsl: Move fsl-ssi binding doc to sound/
In-Reply-To: <1369752478-30260-10-git-send-email-mpa@pengutronix.de>
References: <1369752478-30260-1-git-send-email-mpa@pengutronix.de>
 <1369752478-30260-10-git-send-email-mpa@pengutronix.de>
Message-ID: <20130530085156.GC2670@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 28, 2013 at 04:47:57PM +0200, Markus Pargmann wrote:
> fsl-ssi was located in powerpc/fsl/ssi.txt. This is no powerpc specific
> device, so it should be moved to sound/ as it connects to differen audio
> codecs.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  .../devicetree/bindings/powerpc/fsl/ssi.txt        | 73 ----------------------
>  .../devicetree/bindings/sound/fsl,ssi.txt          | 73 ++++++++++++++++++++++

Please add -M to git format-patch command.

Shawn
