From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 9 Mar 2017 18:10:47 +0800
Subject: [linux-sunxi] [PATCH v3 1/5] dt: bindings: add pmu0 regs for USB
 PHYs on Allwinner H3/V3s/A64
In-Reply-To: <20170306223449.21404-2-icenowy@aosc.xyz>
References: <20170306223449.21404-1-icenowy@aosc.xyz>
 <20170306223449.21404-2-icenowy@aosc.xyz>
Message-ID: <CAGb2v65cxJqkAzQ-s08qf1J_i8OAZFYc6kqrt3WHV_ACEABtSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 7, 2017 at 6:34 AM, Icenowy Zheng <icenowy@aosc.xyz> wrote:
> Allwinner H3/V3s/A64 SoCs have a special USB PHY0 that can route to two
> controllers: one is MUSB and the other is a EHCI/OHCI pair.
>
> When it's routed to EHCI/OHCI pair, it will needs a "pmu0" regs to
> tweak, like other EHCI/OHCI pairs in Allwinner SoCs.
>
> Add this to the binding of USB PHYs on Allwinner H3/V3s/A64.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

Acked-by: Chen-Yu Tsai <wens@csie.org>
