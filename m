From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 7 Feb 2014 20:24:44 +0100
Subject: [PATCH v4 0/8] ARM: sunxi: rename DT clock node names to clk@N
In-Reply-To: <1391392304-4660-1-git-send-email-wens@csie.org>
References: <1391392304-4660-1-git-send-email-wens@csie.org>
Message-ID: <20140207192444.GM3192@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 03, 2014 at 09:51:36AM +0800, Chen-Yu Tsai wrote:
> Hi everyone,
> 
> This is v4 of the clock node renaming patch series, which renames
> the clock nodes in sunxi dts to conform to device tree naming
> conventions, i.e. clk at N. Dummy clocks that will be renamed/removed
> later, or clocks sharing registers are not renamed.
> 
> Renamed clock nodes have clock-output-names properties added to
> desginate their names. Support for this is added in the first
> patch.

Applied the last 4 patches to sunxi/dt-for-3.15.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140207/3aba29dd/attachment.sig>
