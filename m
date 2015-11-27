From: broonie@kernel.org (Mark Brown)
Date: Fri, 27 Nov 2015 12:28:51 +0000
Subject: [PATCH] regulator: core: fix regulator_lock_supply regression
In-Reply-To: <3399746.xt7N4lig0U@wuerfel>
References: <3399746.xt7N4lig0U@wuerfel>
Message-ID: <20151127122851.GO1929@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 27, 2015 at 01:04:30PM +0100, Arnd Bergmann wrote:
> As noticed by Geert Uytterhoeven, my patch to avoid a harmless build warning
> in regulator_lock_supply() was total crap and introduced a real bug:

This doesn't apply against current code, please check and resend.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151127/55bee90b/attachment.sig>
