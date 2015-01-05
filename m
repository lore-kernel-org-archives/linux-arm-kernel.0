From: daniel@ffwll.ch (Daniel Vetter)
Date: Mon, 5 Jan 2015 09:54:24 +0100
Subject: [PATCH RFC v7 16/21] drm: panel: Add support for Himax HX8369A
 MIPI DSI panel
In-Reply-To: <1419910451-15268-17-git-send-email-Ying.Liu@freescale.com>
References: <1419910451-15268-1-git-send-email-Ying.Liu@freescale.com>
 <1419910451-15268-17-git-send-email-Ying.Liu@freescale.com>
Message-ID: <20150105085424.GP2711@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 30, 2014 at 11:34:06AM +0800, Liu Ying wrote:
> This patch adds support for Himax HX8369A MIPI DSI panel.
> 
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
> ---
> v6->v7:
>  * Address Andrzej Hajda's following comments.
>  * Simplify the return logic in hx8369a_dcs_write().
>  * Replace the macro hx8369a_dsi_init_helper() with a function array to improve
>    the code quality.
>  * Handle error cases during getting gpios in probe().
>  * Add 'Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>'.

If you only update one patch in a big series it's imo better to just
resend that one to avoid spamming the mailing list with noise. Imo it also
helps to keep the discussion all nicely grouped together.

In any case please give a short overview of what changed in the cover
letter when resending the entire series so that people don't have to go
through all the invidual patches.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
