From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 6 Jul 2016 18:21:35 +0200
Subject: fix some host driver defect
In-Reply-To: <1467252061-3791-1-git-send-email-chaotian.jing@mediatek.com>
References: <1467252061-3791-1-git-send-email-chaotian.jing@mediatek.com>
Message-ID: <CAPDyKFoZVoZpKh90hG-QoSdwWSgAdV0b6oup-w-dOQ8atRZ+2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 June 2016 at 04:00, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
>
> Chaotian Jing (4):
>   mmc: mediatek: do not tune data for HS400 mode
>   mmc: mediatek: fix CRC error when calling mmc_select_hs400()
>   mmc: mediatek: fix CMD21/CMD19 timeout issue
>   mmc: mediatek: perfer to use rise edge latching
>
>  drivers/mmc/host/mtk-sd.c | 70 +++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 56 insertions(+), 14 deletions(-)
>
> --
> 1.8.1.1.dirty
>

Thanks, applied for next!

Kind regards
Uffe
