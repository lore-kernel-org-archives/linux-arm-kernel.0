From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 24 Mar 2017 10:58:53 +0800
Subject: [linux-sunxi] [PATCH v4 8/8] arm64: allwinner: h5: enable USB OTG
 on Orange Pi PC 2 board
In-Reply-To: <20170319163118.56301-4-icenowy@aosc.xyz>
References: <20170319163118.56301-1-icenowy@aosc.xyz>
 <20170319163118.56301-4-icenowy@aosc.xyz>
Message-ID: <CAGb2v64ZEXGX4ie1Mkmp04xHHHT62OmzTuG1dWNK2R=sFqeZhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 20, 2017 at 12:31 AM, Icenowy Zheng <icenowy@aosc.xyz> wrote:
> Orange Pi PC 2 board features a OTG port like the one on older H3 Orange
> Pi's, with PG12 pin being the id det pin and PL2 being the vbus driver
> pin.
>
> Add support for it.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

Acked-by: Chen-Yu Tsai <wens@csie.org>
