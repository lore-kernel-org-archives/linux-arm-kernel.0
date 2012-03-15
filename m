From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 15 Mar 2012 10:18:37 +0000
Subject: [alsa-devel] [PATCH v4] ASoC: add imx-sgtl5000 machine driver
 working with fsl_ssi
In-Reply-To: <20120315095230.GZ3852@pengutronix.de>
References: <1331553537-19789-1-git-send-email-shawn.guo@linaro.org>
 <20120314090115.GN3852@pengutronix.de>
 <4F612394.4060703@freescale.com>
 <20120315095230.GZ3852@pengutronix.de>
Message-ID: <20120315101836.GA3138@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 15, 2012 at 10:52:31AM +0100, Sascha Hauer wrote:

> I don't know how this AC97 stuff integrates into the devicetree. Anyway,
> that's a topic for future discussions and shouldn't block the current
> patches. I just want to make sure that the original imx-ssi driver is
> not removed as long as the fsl_ssi driver does not have AC97 support.

AC'97 should be hotpluggable once you know the controller is there.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120315/6b377ecc/attachment.sig>
