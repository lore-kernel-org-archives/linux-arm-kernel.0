From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 30 May 2013 11:27:31 +0200
Subject: [PATCH v6 03/10] ASoC: imx-pcm-fiq: Introduce pcm-fiq-params
In-Reply-To: <20130529142648.GC29528@S2101-09.ap.freescale.net>
References: <1369752478-30260-1-git-send-email-mpa@pengutronix.de>
 <1369752478-30260-4-git-send-email-mpa@pengutronix.de>
 <20130529142648.GC29528@S2101-09.ap.freescale.net>
Message-ID: <20130530092731.GD31548@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 29, 2013 at 10:26:50PM +0800, Shawn Guo wrote:
> On Tue, May 28, 2013 at 04:47:51PM +0200, Markus Pargmann wrote:
> > @@ -47,7 +56,8 @@ static inline void imx_pcm_dma_exit(struct platform_device *pdev)
> >  #endif
> >  
> >  #ifdef CONFIG_SND_SOC_IMX_PCM_FIQ
> > -int imx_pcm_fiq_init(struct platform_device *pdev);
> > +int imx_pcm_fiq_init(struct platform_device *pdev,
> > +		struct imx_pcm_fiq_params *params);
> >  void imx_pcm_fiq_exit(struct platform_device *pdev);
> >  #else
> >  static inline int imx_pcm_fiq_init(struct platform_device *pdev)
> 
> This one also needs update with a new parameter.

Fixed, thanks,

Markus

> 
> Shawn
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
