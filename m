From: broonie@kernel.org (Mark Brown)
Date: Wed, 12 Nov 2014 22:29:54 +0000
Subject: [PATCH 4/4 V2] ASoC: rt5631: Adding Device Tree compatibility to
 Realtek's ALC5631 codec driver
In-Reply-To: <1415781339-16089-5-git-send-email-krishna.md@samsung.com>
References: <1415781339-16089-1-git-send-email-krishna.md@samsung.com>
 <1415781339-16089-5-git-send-email-krishna.md@samsung.com>
Message-ID: <20141112222954.GW3815@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 12, 2014 at 02:05:39PM +0530, Krishna Mohan Dani wrote:

> +#ifdef CONFIG_OF
> +		.of_match_table = of_match_ptr(rt5631_i2c_dt_ids),
> +#endif

This is OK apart from this - you don't need the CONFIG_OF around
of_match_ptr().
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141112/26ba98f5/attachment.sig>
