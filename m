From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 5 Jul 2018 16:53:14 +0200
Subject: [linux-sunxi][PATCH v2] ARM: dts: sun8i: h3: Enable dwmac-sun8i
 on the Beelink X2
In-Reply-To: <20180704083003.26849-1-codekipper@gmail.com>
References: <20180704083003.26849-1-codekipper@gmail.com>
Message-ID: <20180705145314.mo3zaux6duxig3zc@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 04, 2018 at 10:30:03AM +0200, codekipper at gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
> 
> The enabling of the EMAC was reverted as there was an issue on how
> to handle the integrated PHY and it was getting close to the release
> window (fe45174b72ae ("arm: dts: sunxi: Revert EMAC changes")).
> 
> When a solution was found, then the changes were restored in
> 4b236a0fe512 ("arm: dts: sunxi: h3/h5: Restore EMAC changes") and
> 4904337fe34f ("ARM: dts: sunxi: Restore EMAC changes (boards)").
> Unfortunately enabling for the Beelink X2 was missed.
> 
> This reverts partially commit 6b0e06df5cad (Revert "ARM: dts:
> sun8i: h3: Enable dwmac-sun8i on the Beelink X2")
> 
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180705/46919338/attachment.sig>
