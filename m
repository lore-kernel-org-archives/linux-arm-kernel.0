From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 03 Jul 2015 23:57:28 +0200
Subject: [PATCH] dts: mt8173-evb: Add da9211 to i2c1
In-Reply-To: <1435890506-25425-1-git-send-email-henryc.chen@mediatek.com>
References: <1435890506-25425-1-git-send-email-henryc.chen@mediatek.com>
Message-ID: <1564415.ZMUL1dYkVh@ubix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, July 03, 2015 10:28:26 AM Henry Chen wrote:
> Add a DA9211 dual-channel BUCK regulator to i2c1.
> This regulator supplies GPU and DVFS1 voltages.
> 
> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> ---
> This patch based on https://github.com/mbgg/linux-mediatek.git
> branch/v4.2-next/arm64 ---
>  arch/arm64/boot/dts/mediatek/mt8173-evb.dts | 30
> +++++++++++++++++++++++++++++ 1 file changed, 30 insertions(+)

applied to v4.2-next/arm64

Thanks.
