From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 17 Jan 2017 17:47:22 +0100
Subject: [PATCH v2 04/10] ASoC: sun4i-i2s: Add quirks to handle new
 compatible for reset
In-Reply-To: <20170117140230.23142-5-mylene.josserand@free-electrons.com>
References: <20170117140230.23142-1-mylene.josserand@free-electrons.com>
 <20170117140230.23142-5-mylene.josserand@free-electrons.com>
Message-ID: <20170117164722.yohrxvlempkjldu3@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 17, 2017 at 03:02:24PM +0100, Myl?ne Josserand wrote:
> Some SoCs have a reset line that must be asserted/deasserted.
> This patch adds a quirk to handle the new compatible
> "allwinner,sun6i-a31-i2s" which will deassert the reset
> line on probe function and assert it on remove's one.
> 
> This new compatible is useful in case of A33 codec driver, for example.
> 
> Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170117/ba3a4f3a/attachment.sig>
