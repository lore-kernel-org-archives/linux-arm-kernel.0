From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 19 Jan 2015 22:59:12 +0100
Subject: [PATCH v4 3/9] ARM: dts: sun9i: Add clock-indices property for
 bus gate clocks
In-Reply-To: <1421471974-32719-4-git-send-email-wens@csie.org>
References: <1421471974-32719-1-git-send-email-wens@csie.org>
 <1421471974-32719-4-git-send-email-wens@csie.org>
Message-ID: <20150119215912.GM4367@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 17, 2015 at 01:19:28PM +0800, Chen-Yu Tsai wrote:
> of_clk_get_parent_name() uses the clock-indices property to resolve
> clock phandle arguments in case that the argument index does not
> match the clock-output-names sequence.
> 
> This is the case on sunxi, where we use the actual bit index as the
> argument to the phandle. Add the clock-indices property so that
> of_clk_get_parent_name() resolves the names correctly.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Did you change anything in that patch?

I already applied it from v3, so let me know if I need to drop it.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150119/55221951/attachment.sig>
