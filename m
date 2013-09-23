From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 23 Sep 2013 14:26:41 +0200
Subject: [PATCH v5 0/4] media: s5p-tv: clean-up and fixes
In-Reply-To: <1379775649-6331-1-git-send-email-m.krawczuk@partner.samsung.com>
References: <1379775649-6331-1-git-send-email-m.krawczuk@partner.samsung.com>
Message-ID: <1439143.k4bEV6oqux@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mateusz,

On Saturday 21 of September 2013 17:00:45 Mateusz Krawczuk wrote:
> This patch series add restoring previous vpll rate after driver offs
> stream or recives error.
> It also replace mxr_info, mxr_dbg, mxr_warn and mxr_err macro
> by generic solution.
> 
> Mateusz Krawczuk (4):
>   media: s5p-tv: Replace mxr_ macro by default dev_
>   media: s5p-tv: Restore vpll clock rate
>   media: s5p-tv: Fix sdo driver to work with CCF
>   media: s5p-tv: Fix mixer driver to work with CCF
> 
>  drivers/media/platform/s5p-tv/mixer.h           |  12 ---
>  drivers/media/platform/s5p-tv/mixer_drv.c       |  81
> ++++++++++++------- drivers/media/platform/s5p-tv/mixer_grp_layer.c |  
> 2 +-
>  drivers/media/platform/s5p-tv/mixer_reg.c       |   6 +-
>  drivers/media/platform/s5p-tv/mixer_video.c     | 100
> ++++++++++++------------ drivers/media/platform/s5p-tv/mixer_vp_layer.c 
> |   2 +-
>  drivers/media/platform/s5p-tv/sdo_drv.c         |  39 +++++++--
>  7 files changed, 137 insertions(+), 105 deletions(-)

For the whole series:

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
