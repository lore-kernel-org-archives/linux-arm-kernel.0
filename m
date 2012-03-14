From: timur@freescale.com (Timur Tabi)
Date: Wed, 14 Mar 2012 18:02:44 -0500
Subject: [PATCH v4] ASoC: add imx-sgtl5000 machine driver working with
 fsl_ssi
In-Reply-To: <20120314090115.GN3852@pengutronix.de>
References: <1331553537-19789-1-git-send-email-shawn.guo@linaro.org>
 <20120314090115.GN3852@pengutronix.de>
Message-ID: <4F612394.4060703@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sascha Hauer wrote:
> What are the next steps here? Now we have fsl_ssi.c and imx-ssi.c, one
> for dt bindings and the other one for platform bindings and also AC97
> support. They should probably get merged some day which might be a bit
> difficult since currently I don't see the platform users moving over
> to devicetree and the seem to be no AC97 users in powerpc.

I don't have any problem with adding AC97 support to fsl_ssi.c, assuming
it's not a huge mess.  I don't know enough about AC97 to know how easy
that is, though.

-- 
Timur Tabi
Linux kernel developer at Freescale
