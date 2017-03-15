From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 15 Mar 2017 15:05:22 +0800
Subject: [linux-sunxi] [PATCH v3 3/5] ARM: dts: sun8i: h3: add usb_otg and
 OHCI/EHCI for usbc0 on H3
In-Reply-To: <20170306223449.21404-4-icenowy@aosc.xyz>
References: <20170306223449.21404-1-icenowy@aosc.xyz>
 <20170306223449.21404-4-icenowy@aosc.xyz>
Message-ID: <CAGb2v64KtKNWVNM9pLbC3VvDnbiib-QLZF4K_wMoS7Qh3n2+2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 7, 2017 at 6:34 AM, Icenowy Zheng <icenowy@aosc.xyz> wrote:
> Allwinner H3 have a dual-routed USB PHY0 -- routed to either OHCI/EHCI
> or MUSB controller.
>
> Add device nodes for these controllers.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

Acked-by: Chen-Yu Tsai <wens@csie.org>
