From: robh@kernel.org (Rob Herring)
Date: Thu, 21 Jan 2016 17:09:40 -0600
Subject: [PATCH] Documentation: rockchip-dw-mshc: add RK3368 dw-mshc
 description
In-Reply-To: <1453379529-5148-1-git-send-email-shawn.lin@rock-chips.com>
References: <1453379529-5148-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <20160121230940.GA1609@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 21, 2016 at 08:32:09PM +0800, Shawn Lin wrote:
> rk3368 dtsi file add dw-mshc compatible "rockchip,rk3368-dw-mshc"
> but didn't add it into rockchip-dw-mshc.txt.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
>  Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>

I'm assuming Heiko will take this.

Rob
