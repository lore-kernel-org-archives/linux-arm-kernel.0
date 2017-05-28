From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 28 May 2017 23:06:38 +0800
Subject: [PATCH v3 03/10] pinctrl: sunxi: add A20 support to A10 driver
In-Reply-To: <20170527102308.1988-4-icenowy@aosc.io>
References: <20170527102308.1988-1-icenowy@aosc.io>
 <20170527102308.1988-4-icenowy@aosc.io>
Message-ID: <CAGb2v67zr5BNub45=Uap86sfs5qOsJiiYyaxqPK8-cbYsrtK9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 27, 2017 at 6:23 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> As A20 is designed as a pin-compatible upgrade of A10, their pin
> controller are very similar, and can share one driver.
>
> Add A20 support to the A10 driver.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
