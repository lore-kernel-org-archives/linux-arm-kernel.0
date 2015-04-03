From: liu.y.victor@gmail.com (Liu Ying)
Date: Fri, 3 Apr 2015 11:28:18 +0800
Subject: [PATCH RFC v9 09/20] drm/dsi: Add a helper to get bits per pixel
 of MIPI DSI pixel format
In-Reply-To: <1425380860.3146.49.camel@pengutronix.de>
References: <1423720903-24806-1-git-send-email-Ying.Liu@freescale.com>
 <1423720903-24806-10-git-send-email-Ying.Liu@freescale.com>
 <1425380860.3146.49.camel@pengutronix.de>
Message-ID: <CA+8Hj80iRz6RTtzOiYvSPmgiR4w6X+hBukXgBkZz3o6+Z4RecA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thierry,

2015-03-03 19:07 GMT+08:00 Philipp Zabel <p.zabel@pengutronix.de>:
> Hi,
>
> Am Donnerstag, den 12.02.2015, 14:01 +0800 schrieb Liu Ying:
>> Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
>> ---
>> v8->v9:
>>  * Rebase onto the imx-drm/next branch of Philipp Zabel's open git repository.
>
> I can't test this myself for lack of hardware, but I see no further
> issues with patches 09 - 13 except for the use of
> imx_drm_encoder_get_mux_id. I'll either rebase my patches that remove it
> or fix it up when applying.
>
> Thierry, may I take these patches through imx-drm, or would you rather I
> waited for you to pick up the drm/dsi and drm/bridge patches?

Gentle ping.  What's your opinion on the patches Philipp mentioned?

Regards,
Liu Ying

>
> regards
> Philipp
>
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Best Regards,
Liu Ying
