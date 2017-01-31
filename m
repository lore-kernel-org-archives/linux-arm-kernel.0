From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 31 Jan 2017 11:31:23 +0100
Subject: [PATCH v3 2/8] ASoC: sun4i-i2s: Add quirks to handle a31
 compatible
In-Reply-To: <20170131100552.27949-3-mylene.josserand@free-electrons.com>
References: <20170131100552.27949-1-mylene.josserand@free-electrons.com>
 <20170131100552.27949-3-mylene.josserand@free-electrons.com>
Message-ID: <20170131103123.6ldkmxhkpaihllmp@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 31, 2017 at 11:05:46AM +0100, Myl?ne Josserand wrote:
> Some SoCs have a reset line that must be asserted/deasserted.
> This patch adds a quirk to handle the new compatible
> "allwinner,sun6i-a31-i2s" which will deassert the reset
> line on probe function and assert it on remove's one.
> 
> This new compatible is useful in case of A33 codec driver, for example.
> 
> Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170131/3f6f1707/attachment.sig>
