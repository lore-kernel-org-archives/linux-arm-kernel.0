From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 29 Aug 2013 12:14:16 +0200
Subject: [PATCH v3 1/6] media: s5p-tv: Replace mxr_ macro by default dev_
In-Reply-To: <1377706384-3697-2-git-send-email-m.krawczuk@partner.samsung.com>
References: <1377706384-3697-1-git-send-email-m.krawczuk@partner.samsung.com>
 <1377706384-3697-2-git-send-email-m.krawczuk@partner.samsung.com>
Message-ID: <1562143.sxFLZnf0g9@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mateusz,

On Wednesday 28 of August 2013 18:12:59 Mateusz Krawczuk wrote:
> Replace mxr_dbg, mxr_info and mxr_warn by generic solution.
> 
> Signed-off-by: Mateusz Krawczuk <m.krawczuk@partner.samsung.com>
> ---
>  drivers/media/platform/s5p-tv/mixer.h           |  12 ---
>  drivers/media/platform/s5p-tv/mixer_drv.c       |  47 ++++++-----
>  drivers/media/platform/s5p-tv/mixer_grp_layer.c |   2 +-
>  drivers/media/platform/s5p-tv/mixer_reg.c       |   6 +-
>  drivers/media/platform/s5p-tv/mixer_video.c     | 100
> ++++++++++++------------ drivers/media/platform/s5p-tv/mixer_vp_layer.c 
> |   2 +-
>  6 files changed, 78 insertions(+), 91 deletions(-)

Although, this is a valid patch, I don't think it is related by any way to 
migration of S5PV210 to common clock framework. So, IMHO, this patch should 
be send separately, not as a part of this series.

Best regards,
Tomasz
