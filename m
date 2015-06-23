From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 23 Jun 2015 22:04:02 +0200
Subject: [PATCH v2 2/2] arm64: dts: mt8173: Add I2C device node
In-Reply-To: <1433164107-26568-3-git-send-email-eddie.huang@mediatek.com>
References: <1433164107-26568-1-git-send-email-eddie.huang@mediatek.com>
 <1433164107-26568-3-git-send-email-eddie.huang@mediatek.com>
Message-ID: <5279457.I1q8kC8mJN@ubix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, June 01, 2015 09:08:27 PM Eddie Huang wrote:
> Add MT8173 I2C device nodes, include I2C controllers and pins.
> MT8173 has six I2C controllers, from i2c0 to i2c6, exclude i2c5.
> The 6th I2C controller register base doesn't next to 5th I2C,
> and there is a hardware between 5th and 6th I2C controller. So
> SoC designer name 6th controller as "i2c6", not "i2c5".
> 
> Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
> ---

applied to v4.2-next/arm64

Thanks.
