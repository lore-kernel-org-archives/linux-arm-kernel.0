From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 6 Mar 2012 23:50:57 +0800
Subject: [PATCH v2 17/17] ASoC: fsl: add imx-sgtl5000 machine driver
In-Reply-To: <20120305174232.GA3852@pengutronix.de>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
 <1330957865-19085-18-git-send-email-shawn.guo@linaro.org>
 <20120305174232.GA3852@pengutronix.de>
Message-ID: <20120306155055.GA13802@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 05, 2012 at 06:42:32PM +0100, Sascha Hauer wrote:
> On Mon, Mar 05, 2012 at 10:31:05PM +0800, Shawn Guo wrote:
> > This is the initial imx-sgtl5000 machine driver support with only
> > playback dai link implemented.  More features can be added on top
> > of it later.
> 
> Are there problems with capturing? It should be trivial to add and
> it would be much more confident that this series as a whole works as
> expected.
> 
I worked all day long to try to give that answer.  Here it is.

No, there is no problem with capturing on fsl_ssi + imx_pcm_dma +
imx_sgtl5000 side.  But there is a problem with sgtl5000 codec driver.
With that problem fixed in sgtl5000, this series works just fine with
capturing.  (I'm not sure I want to fix it within this series though,
as it's already big enough.)

-- 
Regards,
Shawn
