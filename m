From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 3 Apr 2018 10:46:55 +0200
Subject: [PATCH v5 11/13] ARM: sun9i: smp: Add is_sun9i field
In-Reply-To: <20180403061836.3926-12-mylene.josserand@bootlin.com>
References: <20180403061836.3926-1-mylene.josserand@bootlin.com>
 <20180403061836.3926-12-mylene.josserand@bootlin.com>
Message-ID: <20180403084655.x6u7s4jzqdvq2eey@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 03, 2018 at 08:18:34AM +0200, Myl?ne Josserand wrote:
> To prepare the support of sun8i-a83t, add a field in the smp_data
> structure to enable the case of sun9i.
> 
> Start to handle the differences between sun9i-a80 and sun8i-a83t
> by using this variable.
>
> Add an index to retrieve which structures we are using.

This should have been in a separate commit, but maybe we can store a
pointer to the array cell we're using instead of always using the
index?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180403/8a29e4de/attachment.sig>
