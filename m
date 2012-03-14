From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 14 Mar 2012 19:33:00 +0800
Subject: [PATCH v4] ASoC: add imx-sgtl5000 machine driver working with
 fsl_ssi
In-Reply-To: <20120314090115.GN3852@pengutronix.de>
References: <1331553537-19789-1-git-send-email-shawn.guo@linaro.org>
 <20120314090115.GN3852@pengutronix.de>
Message-ID: <20120314113258.GG21337@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 14, 2012 at 10:01:15AM +0100, Sascha Hauer wrote:
...
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
Thanks.

> What are the next steps here? Now we have fsl_ssi.c and imx-ssi.c, one
> for dt bindings and the other one for platform bindings and also AC97
> support. They should probably get merged some day which might be a bit
> difficult since currently I don't see the platform users moving over
> to devicetree and the seem to be no AC97 users in powerpc.
> 
When I was tasked to add DT support for imx5 audio driver, it was my
first attempt to add it on top of imx-ssi driver.  But Timur strongly
disagree with that.  Instead, he asked me to reuse fsl_ssi.  That's
why I came up with this series.  I did not really plan to completely
remove imx-ssi by merging it into fsl_ssi.  But if someday we have all
those imx-ssi users migrated to DT, that will become something we
should consider to do then.

-- 
Regards,
Shawn
