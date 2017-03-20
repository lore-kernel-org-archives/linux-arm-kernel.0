From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 20 Mar 2017 22:31:48 +0800
Subject: [linux-sunxi] [PATCH v4 1/8] dt: bindings: add pmu0 regs for USB
 PHYs on Allwinner H3/V3s/A64
In-Reply-To: <20170319161951.55834-2-icenowy@aosc.xyz>
References: <20170319161951.55834-1-icenowy@aosc.xyz>
 <20170319161951.55834-2-icenowy@aosc.xyz>
Message-ID: <CAGb2v66mZC2e=sZvZL2kmV0YAfVx3eeHUMvbGiEXN9pFgXtaXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 20, 2017 at 12:19 AM, Icenowy Zheng <icenowy@aosc.xyz> wrote:
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

Please keep acks and review tags from others if you haven't changed the
patch.
