From: robh@kernel.org (Rob Herring)
Date: Thu, 28 Jan 2016 21:01:15 -0600
Subject: [PATCH] Documentation: rockchip-dw-mshc: add RK3036 dw-mshc
 description
In-Reply-To: <1453775654-16105-1-git-send-email-shawn.lin@rock-chips.com>
References: <1453775654-16105-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <20160129030115.GA11954@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2016 at 10:34:14AM +0800, Shawn Lin wrote:
> rk3036 dtsi file add dw-mshc compatible "rockchip,rk3036-dw-mshc"
> but didn't add it into rockchip-dw-mshc.txt.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
>  Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
