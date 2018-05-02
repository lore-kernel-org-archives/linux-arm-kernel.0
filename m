From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 2 May 2018 15:14:31 +0200
Subject: [PATCH v8 10/12] ARM: sun8i: smp: Add support for A83T
In-Reply-To: <20180501123131.7738-11-mylene.josserand@bootlin.com>
References: <20180501123131.7738-1-mylene.josserand@bootlin.com>
 <20180501123131.7738-11-mylene.josserand@bootlin.com>
Message-ID: <20180502131431.j7jaz74ko5ueotwn@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 01, 2018 at 02:31:29PM +0200, Myl?ne Josserand wrote:
> Add the support for A83T.
> 
> A83T SoC has an additional register than A80 to handle CPU configurations:
> R_CPUS_CFG. Information about the register comes from Allwinner's BSP
> driver.
> An important difference is the Power Off Gating register for clusters
> which is BIT(4) in case of SUN9I-A80 and BIT(0) in case of SUN8I-A83T.
> There is also a bit swap between sun8i-a83t and sun9i-a80 that must be
> handled.
> 
> Signed-off-by: Myl?ne Josserand <mylene.josserand@bootlin.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180502/8c1ae706/attachment-0001.sig>
