From: jcliang@chromium.org (Ricky Liang)
Date: Sun, 18 Dec 2016 14:53:20 +0800
Subject: [PATCH v9 2/4] vcodec: mediatek: Add Mediatek JPEG Decoder Driver
In-Reply-To: <1481702690-10476-3-git-send-email-rick.chang@mediatek.com>
References: <1481702690-10476-1-git-send-email-rick.chang@mediatek.com>
 <1481702690-10476-3-git-send-email-rick.chang@mediatek.com>
Message-ID: <CAAJzSMfb=_Td+_f-q0mOTX5dGFC1Roxxm7+-yjavKFo3DO8YUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2016 at 4:04 PM, Rick Chang <rick.chang@mediatek.com> wrote:
> Add v4l2 driver for Mediatek JPEG Decoder
>
> Signed-off-by: Rick Chang <rick.chang@mediatek.com>
> Signed-off-by: Minghsiu Tsai <minghsiu.tsai@mediatek.com>
> ---
>  drivers/media/platform/Kconfig                   |   15 +
>  drivers/media/platform/Makefile                  |    2 +
>  drivers/media/platform/mtk-jpeg/Makefile         |    2 +
>  drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c  | 1306 ++++++++++++++++++++++
>  drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h  |  139 +++
>  drivers/media/platform/mtk-jpeg/mtk_jpeg_hw.c    |  417 +++++++
>  drivers/media/platform/mtk-jpeg/mtk_jpeg_hw.h    |   91 ++
>  drivers/media/platform/mtk-jpeg/mtk_jpeg_parse.c |  160 +++
>  drivers/media/platform/mtk-jpeg/mtk_jpeg_parse.h |   25 +
>  drivers/media/platform/mtk-jpeg/mtk_jpeg_reg.h   |   58 +
>  10 files changed, 2215 insertions(+)

Reviewed-by: Ricky Liang <jcliang@chromium.org>
Tested-by: Ricky Liang <jcliang@chromium.org>
