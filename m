From: robh@kernel.org (Rob Herring)
Date: Wed, 15 Feb 2017 20:20:16 -0600
Subject: [PATCH 1/4] Documentation: bindings: add uphy-dp-sel for
 Rockchip USB Type-C PHY
In-Reply-To: <1486712654-15431-2-git-send-email-zyw@rock-chips.com>
References: <1486712654-15431-1-git-send-email-zyw@rock-chips.com>
 <1486712654-15431-2-git-send-email-zyw@rock-chips.com>
Message-ID: <20170216022016.ubspejlr7no7ttgl@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 10, 2017 at 03:44:11PM +0800, Chris Zhong wrote:
> rockchip,uphy-dp-sel is the register of type-c phy enable DP function.

"dt-bindings: phy:" is the preferred subject prefix.

> 
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> ---
> 
>  Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt | 5 +++++
>  1 file changed, 5 insertions(+)

Otherwise,

Acked-by: Rob Herring <robh@kernel.org> 
