From: broonie@kernel.org (Mark Brown)
Date: Fri, 9 Jan 2015 16:04:49 +0000
Subject: [PATCH v5][resend v4] of: replace Asahi Kasei Corp vendor prefix
In-Reply-To: <5363275.ZK3ulH6EUO@wuerfel>
References: <878ulzx6hr.wl%kuninori.morimoto.gx@gmail.com>
 <871tn4uv0j.wl%kuninori.morimoto.gx@renesas.com>
 <CAL_Jsq+GjM+3M63amyh3Rvijkz7Lch_cdUt9vScc9wZeOubOPA@mail.gmail.com>
 <5363275.ZK3ulH6EUO@wuerfel>
Message-ID: <20150109160449.GG2634@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 09, 2015 at 02:55:40PM +0100, Arnd Bergmann wrote:

> It's an i2c device, so it won't break, based on the implementation
> we use in the kernel that ignores the vendor part when the part number
> matches the i2c driver name.

Plus this update is actually changing the board DT file have the ID
which we've always had in the driver, the driver has always used the new
string and never the ak, based one that the device tree is registering.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150109/0fb11c03/attachment.sig>
