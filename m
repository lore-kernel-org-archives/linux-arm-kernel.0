From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Mon, 3 Sep 2018 20:09:31 +0200
Subject: [PATCH v5] usb: core: phy: clean up return value check about
 devm_of_phy_get_by_index()
In-Reply-To: <18d8d311a32497abce39c796b353a878a13b09b6.1535709565.git.chunfeng.yun@mediatek.com>
References: <18d8d311a32497abce39c796b353a878a13b09b6.1535709565.git.chunfeng.yun@mediatek.com>
Message-ID: <CAFBinCB8J1TP_xsg8cprHBzQrNwUVg7TxbRBw3GamyWUe8yH7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 31, 2018 at 12:02 PM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
>
> Use IS_ERR() instead of IS_ERR_OR_NULL() because devm_of_phy_get_by_index()
> never return NULL value;
> But still need ignore the error of -ENODEV, for more information, please
> refer to:
> [0] https://lkml.org/lkml/2018/4/19/88
> [1] https://patchwork.kernel.org/patch/10160181/
>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Reviewed-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

thanks to both of you for fixing my code!


Regards
Martin
