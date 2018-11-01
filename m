From: jagan@amarulasolutions.com (Jagan Teki)
Date: Thu, 1 Nov 2018 13:08:04 +0530
Subject: [linux-sunxi] [PATCH 0/5] Allwinner H6 Ethernet support
In-Reply-To: <20180722053955.25266-1-icenowy@aosc.io>
References: <20180722053955.25266-1-icenowy@aosc.io>
Message-ID: <CAMty3ZCcxGm0+5LcDXd+6zXVM03bCbdT7p+MXQ6LTp1MJYu48w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 22, 2018 at 11:10 AM Icenowy Zheng <icenowy@aosc.io> wrote:
>
> This patchset introduces Allwinner H6 Ethernet support with code already
> available for A64.
>
> As the system controller and EMAC on H6 are all similar to A64 ones,
> support for them are directly reused, by using fallback compatible
> strings.
>
> Icenowy Zheng (5):
>   dt-binding: dwmac-sun8i: add H6 compatible string (w/ A64 fallback)
>   dt-bindings: sunxi-sram: add binding for Allwinner H6 SRAM C
>   arm64: allwinner: h6: add system controller device tree node
>   arm64: allwinner: h6: add EMAC device nodes
>   arm64: allwinner: h6: add support for the Ethernet on Pine H64

Tested EMAC on Orangepi 1+

Tested-by: Jagan Teki <jagan@amarulasolutions.com>
