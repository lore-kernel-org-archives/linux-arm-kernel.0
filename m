From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 2 May 2018 15:09:08 +0200
Subject: [PATCH v8 09/12] ARM: sun9i: smp: Add is_a83t field
In-Reply-To: <20180501123131.7738-10-mylene.josserand@bootlin.com>
References: <20180501123131.7738-1-mylene.josserand@bootlin.com>
 <20180501123131.7738-10-mylene.josserand@bootlin.com>
Message-ID: <20180502130908.nuykfypradbmggs5@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 01, 2018 at 02:31:28PM +0200, Myl?ne Josserand wrote:
> To prepare the support of sun8i-a83t, add a field in the smp_data
> structure to know if we are on sun9i-a80 or sun8i-a83t.
> 
> Add also a global variable to retrieve which architecture we are
> having.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180502/686825ce/attachment.sig>
