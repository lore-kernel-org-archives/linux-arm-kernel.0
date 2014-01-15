From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 15 Jan 2014 08:46:00 +0100
Subject: [PATCH v3 1/8] clk: sunxi: add clock-output-names dt property
 support
In-Reply-To: <1389257565-19797-2-git-send-email-wens@csie.org>
References: <1389257565-19797-1-git-send-email-wens@csie.org>
 <1389257565-19797-2-git-send-email-wens@csie.org>
Message-ID: <20140115074600.GB3377@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 09, 2014 at 04:52:38PM +0800, Chen-Yu Tsai wrote:
> sunxi clock drivers use dt node name as clock name, but clock
> nodes should be named clk at X, so the names would be the same.
> Let the drivers read clock names from dt clock-output-names
> property.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140115/1f5378c8/attachment.sig>
