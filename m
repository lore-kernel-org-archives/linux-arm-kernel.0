From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 03 Mar 2015 12:07:40 +0100
Subject: [PATCH RFC v9 09/20] drm/dsi: Add a helper to get bits per
 pixel of MIPI DSI pixel format
In-Reply-To: <1423720903-24806-10-git-send-email-Ying.Liu@freescale.com>
References: <1423720903-24806-1-git-send-email-Ying.Liu@freescale.com>
 <1423720903-24806-10-git-send-email-Ying.Liu@freescale.com>
Message-ID: <1425380860.3146.49.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Donnerstag, den 12.02.2015, 14:01 +0800 schrieb Liu Ying:
> Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
> ---
> v8->v9:
>  * Rebase onto the imx-drm/next branch of Philipp Zabel's open git repository.

I can't test this myself for lack of hardware, but I see no further
issues with patches 09 - 13 except for the use of
imx_drm_encoder_get_mux_id. I'll either rebase my patches that remove it
or fix it up when applying.

Thierry, may I take these patches through imx-drm, or would you rather I
waited for you to pick up the drm/dsi and drm/bridge patches?

regards
Philipp
