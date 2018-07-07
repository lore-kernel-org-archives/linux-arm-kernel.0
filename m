From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 7 Jul 2018 11:38:52 +0800
Subject: [linux-sunxi] [PATCH v2 5/9] arm64: allwinner: dts: h6: enable
 USB2 on Pine H64
In-Reply-To: <20180706153805.25842-6-icenowy@aosc.io>
References: <20180706153805.25842-1-icenowy@aosc.io>
 <20180706153805.25842-6-icenowy@aosc.io>
Message-ID: <CAGb2v67ataiu6JiZRwdDbbT5WECKmxbxxTTSgfZ_fkY40ok8Og@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 6, 2018 at 11:38 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> Pine H64 board has both the USB2 OTG port and the USB2 host port on H6

Nit: USB* pins. A "port" implies something you can plug into.

ChenYu

> SoC wired out to USB Type-A port.
>
> Enable them.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
