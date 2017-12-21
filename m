From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 21 Dec 2017 16:05:17 +0800
Subject: [PATCH resend] arm: dts: ls1021a: add reboot node to .dtsi
In-Reply-To: <1512461568-12102-1-git-send-email-rasmus.villemoes@prevas.dk>
References: <1510566980-26602-1-git-send-email-rasmus.villemoes@prevas.dk>
 <1512461568-12102-1-git-send-email-rasmus.villemoes@prevas.dk>
Message-ID: <20171221080516.GH23230@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 05, 2017 at 09:12:47AM +0100, Rasmus Villemoes wrote:
> The LS1021A can be reset via the dcfg regmap in the same way as the
> arm64 layerscape SoCs, so add the corresponding DT node.
> 
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

We use "ARM: ..." instead of "arm: ..." as prefix for DTS patches going
through i.MX tree.

I fixed prefix up and applied the patch.

Shawn
