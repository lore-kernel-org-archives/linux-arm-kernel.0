From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 25 Jun 2016 09:13:38 +0200
Subject: [PATCH v2 01/14] ARM: clk: sunxi: Add driver for the H3 THS clock
In-Reply-To: <20160625034511.7966-2-megous@megous.com>
References: <20160625034511.7966-1-megous@megous.com>
 <20160625034511.7966-2-megous@megous.com>
Message-ID: <20160625071338.GC4000@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Jun 25, 2016 at 05:44:58AM +0200, megous at megous.com wrote:
> From: Josef Gajdusek <atx@atx.name>
> 
> This patch adds a driver for the THS clock which is present on the
> Allwinner H3.
>
> Signed-off-by: Josef Gajdusek <atx@atx.name>

You might not have noticed, but we are currently rewriting the whole
clock support for the Allwinner SoCs, targetting the H3 as the first
SoC to use it.

There's already some support for the H3 THS clock, so please use that
instead.

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
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160625/2b01cef9/attachment.sig>
