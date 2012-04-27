From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 27 Apr 2012 21:05:04 +0800
Subject: [PATCH 06/17] ARM: imx: use machine specific hook for late init
In-Reply-To: <20120427090508.GD17184@pengutronix.de>
References: <1335454725-13089-1-git-send-email-shawn.guo@linaro.org>
 <1335454725-13089-7-git-send-email-shawn.guo@linaro.org>
 <20120427090508.GD17184@pengutronix.de>
Message-ID: <20120427130501.GA2234@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2012 at 11:05:08AM +0200, Sascha Hauer wrote:
> On Thu, Apr 26, 2012 at 11:38:34PM +0800, Shawn Guo wrote:
> > Cc: Sascha Hauer <kernel@pengutronix.de>
> > -static int __init eet_init_devices(void)
> > +int __init pcm037_eet_init_devices(void)
> >  {
> > -	if (!machine_is_pcm037() || pcm037_variant() != PCM037_EET)
> > -		return 0;
> 
> The pcm037_variant() != PCM037_EET gets lost here.
> 
Yes.  Thanks for the catching.  Will fix it.

-- 
Regards,
Shawn
