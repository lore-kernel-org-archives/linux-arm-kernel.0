From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 21 Mar 2017 14:21:01 +0800
Subject: [linux-sunxi] [PATCH v4 6/8] ARM: sun8i: h3: enable USB OTG on
 Orange Pi One
In-Reply-To: <20170319163118.56301-2-icenowy@aosc.xyz>
References: <20170319163118.56301-1-icenowy@aosc.xyz>
 <20170319163118.56301-2-icenowy@aosc.xyz>
Message-ID: <CAGb2v67dodvML-yvK820d=igtzcDOPFqrmOmdTtQd3id89364A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 20, 2017 at 12:31 AM, Icenowy Zheng <icenowy@aosc.xyz> wrote:
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
