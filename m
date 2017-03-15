From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 15 Mar 2017 15:05:43 +0800
Subject: [linux-sunxi] [PATCH v3 4/5] ARM: dts: sun8i: h3: enable USB OTG
 on Orange Pi One
In-Reply-To: <20170306223449.21404-5-icenowy@aosc.xyz>
References: <20170306223449.21404-1-icenowy@aosc.xyz>
 <20170306223449.21404-5-icenowy@aosc.xyz>
Message-ID: <CAGb2v64-L5dnoOch5ErCvJT-R_1n7JSf1oBoK0Ff=X7SSPei5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 7, 2017 at 6:34 AM, Icenowy Zheng <icenowy@aosc.xyz> wrote:
> Orange Pi One features a MicroUSB port that can work in both host mode
> and peripheral mode.
>
> When in host mode, its VBUS is controlled via a GPIO; when in peripheral
> mode, its VBUS cannot be used to power up the board.
>
> Add support for this port.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

Acked-by: Chen-Yu Tsai <wens@csie.org>
