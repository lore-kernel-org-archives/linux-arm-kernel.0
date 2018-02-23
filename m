From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 23 Feb 2018 15:56:50 +0100
Subject: [PATCH v4 02/10] ARM: sun9i: smp: Rename clusters's power-off
 register
In-Reply-To: <20180223133742.26044-3-mylene.josserand@bootlin.com>
References: <20180223133742.26044-1-mylene.josserand@bootlin.com>
 <20180223133742.26044-3-mylene.josserand@bootlin.com>
Message-ID: <20180223145650.dzhdhh2cprqioq5m@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 23, 2018 at 02:37:34PM +0100, Myl?ne Josserand wrote:
> To prepare the support for sun8i-a83t, rename the variable name
> that handles the power-off of clusters because it is different from
> sun9i-a80 to sun8i-a83t.
>
> The power off register for clusters are different from SUN9I and SUN8I

This is just a nitpick, and I see you use them everywhere, but sun8i
and sun9i are the family of SoCs, and A80 and A83t the name of SoCs
within their respective families.

So in your commit log, you want to support the A83t because it's
different than the A80, and the sun9i and sun8i mentionned in your
last sentence is not really meaningful.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180223/88cf636f/attachment.sig>
