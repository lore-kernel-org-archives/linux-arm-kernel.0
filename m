From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 28 Nov 2018 14:42:28 +0100
Subject: [PATCH 33/77] ARM: dts: sun6i: colombus: Change i2c node name to
 avoid warnings
In-Reply-To: <CAGb2v66q34OAOpxS-yC=aRXUJ9BbAnK+9OJav5W8vn-sTy8Mvg@mail.gmail.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <c89c360f86fcbc48d9e11fdb02ba2d65245a4643.1543321707.git-series.maxime.ripard@bootlin.com>
 <CAGb2v66q34OAOpxS-yC=aRXUJ9BbAnK+9OJav5W8vn-sTy8Mvg@mail.gmail.com>
Message-ID: <20181128134228.ukvffkj6bbhycfuj@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 07:51:52PM +0800, Chen-Yu Tsai wrote:
> On Tue, Nov 27, 2018 at 8:46 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > Our I2C GPIO bus node name has a unit address, but no reg property, which
> > generates a warning in DTC. Change the name to remove that unit address.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> 
> Acked-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181128/0890ca87/attachment.sig>
