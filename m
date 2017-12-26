From: davem@davemloft.net (David Miller)
Date: Tue, 26 Dec 2017 12:06:10 -0500 (EST)
Subject: [PATCH net 2/2] net: mediatek: remove superfluous pin setup
 for MT7622 SoC
In-Reply-To: <e3bd43a5337df719e791bc9902135a0916a951ff.1513762066.git.sean.wang@mediatek.com>
References: <e366efc29985d3292c8a1afb1389b5eac57c9037.1513762066.git.sean.wang@mediatek.com>
 <e3bd43a5337df719e791bc9902135a0916a951ff.1513762066.git.sean.wang@mediatek.com>
Message-ID: <20171226.120610.873465773072675214.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: <sean.wang@mediatek.com>
Date: Wed, 20 Dec 2017 17:47:06 +0800

> From: Sean Wang <sean.wang@mediatek.com>
> 
> Remove superfluous pin setup to get out of accessing invalid I/O pin
> registers because the way for pin configuring tends to be different from
> various SoCs and thus it should be better being managed and controlled by
> the pinctrl driver which MT7622 already can support.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Applied to net-next.
