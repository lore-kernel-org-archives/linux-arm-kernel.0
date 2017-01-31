From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 31 Jan 2017 11:30:41 +0100
Subject: [PATCH v3 1/8] ASoC: sun4i-i2s: Update binding documentation to
 include A31
In-Reply-To: <20170131100552.27949-2-mylene.josserand@free-electrons.com>
References: <20170131100552.27949-1-mylene.josserand@free-electrons.com>
 <20170131100552.27949-2-mylene.josserand@free-electrons.com>
Message-ID: <20170131103041.aau37qnm2wc5ug5m@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 31, 2017 at 11:05:45AM +0100, Myl?ne Josserand wrote:
> Add a new compatible for sun4i-i2s driver to handle some
> SoCs that have a reset line that must be asserted/deasserted.
> 
> This new compatible, "allwinner,sun6i-a31-i2s", requires the
> property "resets" which should be a phandle to the reset line.
> Except these differences, the compatible is identical to previous one
> which will not handle a reset line.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170131/e69f5b99/attachment-0001.sig>
