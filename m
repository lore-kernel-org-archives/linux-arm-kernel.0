From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 4 May 2015 11:04:14 +0200
Subject: [PATCH v2 2/2] arm64: dts: mt8173: Fixup pinctrl nodes
In-Reply-To: <1430462971-28195-2-git-send-email-yingjoe.chen@mediatek.com>
References: <1430462971-28195-1-git-send-email-yingjoe.chen@mediatek.com>
 <1430462971-28195-2-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <CABuKBeJNCjpP2o-AAjSG9wrq=aRcLKy90RoyeS3Qmh4=gqohpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-01 8:49 GMT+02:00 Yingjoe Chen <yingjoe.chen@mediatek.com>:
> The 8173 pinctrl node doesn't follow dts convention. Fix them.
> Also add a comment to explain pinctrl register usage to make it
> more clear.
>
> Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
> ---
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)

applied to v4.1-next/arm64

Thanks,
Matthias
