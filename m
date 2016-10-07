From: djkurtz@chromium.org (Daniel Kurtz)
Date: Fri, 7 Oct 2016 18:37:48 +0800
Subject: [PATCH 0/2] fix issue: vblank interrupts are never disabled
In-Reply-To: <1475119789-64619-1-git-send-email-bibby.hsieh@mediatek.com>
References: <1475119789-64619-1-git-send-email-bibby.hsieh@mediatek.com>
Message-ID: <CAGS+omDG9ge+U4kXQcmV_YDO8frWh8V5RAZ=107jHo4Uq_QBeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 29, 2016 at 11:29 AM, Bibby Hsieh <bibby.hsieh@mediatek.com> wrote:
>
> Clean the interrupt status before enable interrupt
> and set the vblank_disable_allowed to fix the issue.

For the series:

Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>

>
> Bibby Hsieh (2):
>   drm/mediatek: set vblank_disable_allowed to true
>   drm/mediatek: clear IRQ status before enable OVL interrupt
>
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c |    1 +
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c  |    1 +
>  2 files changed, 2 insertions(+)
>
> --
> 1.7.9.5
>
