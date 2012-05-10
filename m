From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 10 May 2012 20:13:29 +0800
Subject: [alsa-devel] [PATCH 3/6] ASoC: mxs: mxs-pcm does not need to be
 a plaform_driver
In-Reply-To: <20120510092554.GI6622@shlinux2.ap.freescale.net>
References: <1336639333-11561-1-git-send-email-shawn.guo@linaro.org>
 <1336639333-11561-4-git-send-email-shawn.guo@linaro.org>
 <20120510092554.GI6622@shlinux2.ap.freescale.net>
Message-ID: <20120510121326.GK17875@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2012 at 05:25:55PM +0800, Dong Aisheng wrote:
> > -failed_pdev_alloc:
> > -	snd_soc_unregister_dai(&pdev->dev);
> Do not need to unregister_dai in case mxs_pcm_platform_register failed?
> 
Yeah, my fingers moved so fast to remove code.  Thanks for catching it.

-- 
Regards,
Shawn
