From: julian.calaby@gmail.com (Julian Calaby)
Date: Sat, 3 Feb 2018 17:00:33 +1100
Subject: [linux-sunxi] [PATCH 1/3] net: stmmac: dwmac-sun8i: drop V3s
 compatible and add V3 one
In-Reply-To: <20180202180456.60378-2-icenowy@aosc.io>
References: <20180202180456.60378-1-icenowy@aosc.io>
 <20180202180456.60378-2-icenowy@aosc.io>
Message-ID: <CAGRGNgXy5ZUdCj34jG5kJ8yLZLbcZie5tkvYP08sFpMmAjwPNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Icenowy,

On Sat, Feb 3, 2018 at 5:04 AM, Icenowy Zheng <icenowy@aosc.io> wrote:
> The V3s is just a differently packaged version of the V3 chip, which has
> a MAC with the same capability with H3. The V3s just doesn't wire out
> the external MII/RMII/RGMII bus. (V3 wired out it).
>
> Drop the compatible string of V3s in the dwmac-sun8i driver, and add a
> V3 compatible string, which has all capabilities.

Aren't compatible strings technically API, so don't we need to support
those that are out in the wild "forever"?

Therefore shouldn't we leave the v3s variant around for compatibility
with existing device trees?

Thanks,

-- 
Julian Calaby

Email: julian.calaby at gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
