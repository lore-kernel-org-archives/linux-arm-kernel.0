From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 24 Mar 2017 10:57:54 +0800
Subject: [linux-sunxi] [PATCH v4 7/8] ARM: sun8i: h2+: enable USB OTG for
 Orange Pi Zero board
In-Reply-To: <20170319163118.56301-3-icenowy@aosc.xyz>
References: <20170319163118.56301-1-icenowy@aosc.xyz>
 <20170319163118.56301-3-icenowy@aosc.xyz>
Message-ID: <CAGb2v65sWjn9RWTgv4U00_1h9bgmYPY8mNbx9hAy5Cd0dyxxyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 20, 2017 at 12:31 AM, Icenowy Zheng <icenowy@aosc.xyz> wrote:
> Orange Pi Zero board features a USB OTG port, which has a ID pin, and
> can be used to power up the board. However, even if the board is powered
> via +5V pin in GPIO/expansion headers, the VBUS in the OTG port cannot
> be powered up, thus it's impossible to use it in host mode with simple
> OTG cables.
>
> Add support for it in peripheral mode.
>
> If someone really want to use it in host mode, the mode of PHY can be
> switch via sysfs, then use a powered USB OTG cable or powered USB HUB to
> power up external USB devices.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

Acked-by: Chen-Yu Tsai <wens@csie.org>
