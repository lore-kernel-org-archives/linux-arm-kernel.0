From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 12 Dec 2016 16:51:35 +0100
Subject: [PATCH v2 06/11] mfd: axp20x: add separate MFD cell for AXP223
In-Reply-To: <20161209110419.28981-7-quentin.schulz@free-electrons.com>
References: <20161209110419.28981-1-quentin.schulz@free-electrons.com>
 <20161209110419.28981-7-quentin.schulz@free-electrons.com>
Message-ID: <20161212155135.oyzzn3ssy3pilcgu@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 09, 2016 at 12:04:14PM +0100, Quentin Schulz wrote:
> The AXP223 shares most of its logic with the AXP221 but has some
> differences for the VBUS power supply driver. Thus, to probe the driver
> with the correct compatible, the AXP221 and the AXP223 now have separate
> MFD cells.
> 
> AXP221 MFD cells are renamed from axp22x_cells to axp221_cells to avoid
> confusion.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Acked-by: Chen-Yu Tsai <wens@csie.org>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161212/6c2ec2c4/attachment.sig>
