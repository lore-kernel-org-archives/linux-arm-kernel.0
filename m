From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 01 Aug 2018 14:33:36 +0200
Subject: [PATCH] drm/rockchip: Convert drm_atomic_helper_suspend/resume()
In-Reply-To: <20180731203430.GA30136@jordon-HP-15-Notebook-PC>
References: <20180731203430.GA30136@jordon-HP-15-Notebook-PC>
Message-ID: <16141309.kTfAWOe8rM@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Souptick,

Am Dienstag, 31. Juli 2018, 22:34:30 CEST schrieb Souptick Joarder:
> convert drm_atomic_helper_suspend/resume() to use
> drm_mode_config_helper_suspend/resume().
> 
> With this conversion, rockchip_drm_fb_resume() and
> rockchip_drm_fb_suspend() will not be used anymore.
> Both of these functions can be removed.
> 
> Also, in struct rockchip_drm_private state will not be
> used anymore. So this can be removed forever.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>

the patch itself looks great, just a simple bookkeeping question.

What role did Ajit play in creating the patch? If I remember correctly
it is meant to be
- 1st Signed-off: Patch-Author
- 2nd Signed-off: E-Mail sender + patch possibly patch changes
(optional of course if the same)

So was this meant to be a Reviewed-by from Ajit?


Thanks
Heiko
