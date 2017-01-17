From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 17 Jan 2017 17:44:15 +0100
Subject: [PATCH v2 02/10] clk: ccu-sun8i-a33: Add CLK_SET_RATE_PARENT to
 ac-dig
In-Reply-To: <20170117140230.23142-3-mylene.josserand@free-electrons.com>
References: <20170117140230.23142-1-mylene.josserand@free-electrons.com>
 <20170117140230.23142-3-mylene.josserand@free-electrons.com>
Message-ID: <20170117164415.4qseqbqkdx3e6bvt@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 17, 2017 at 03:02:22PM +0100, Myl?ne Josserand wrote:
> The audio DAI needs to set the clock rates of the ac-dig clock.
> To make it possible, the parent PLL audio clock rates should
> also be changed. This is possible via "CLK_SET_RATE_PARENT" flag.
> 
> Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>

Please make sure to look at the prefixes usually used in the commit
titles of the area you're working on. In this case that would have
been "clk: sunxi-ng:". I fixed it, and applied.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170117/601fc082/attachment.sig>
