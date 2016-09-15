From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 15 Sep 2016 10:34:36 +0200
Subject: [PATCH 0/3] clk: sunxi-ng: sun6i-a31: Register offset and clk
 flag fixes
In-Reply-To: <20160915065740.13664-1-wens@csie.org>
References: <20160915065740.13664-1-wens@csie.org>
Message-ID: <20160915083436.GC10128@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Sep 15, 2016 at 02:57:37PM +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> Here are 3 fixes for the new sunxi-ng clk driver for sun6i-a31 recently
> introduced for 4.9. The issues were noticed while working on the display
> pipeline for the A31/A31s. The second patch follows what Maxime has done
> for the A33 CCU driver. The third issue was noticed while doing the first
> patch.
> 
> I hope we can get this into 4.9 as well, either right in -rc1, or in a
> later -rc.

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Stephen, could you apply those patches directly on top of my previous
PR, or do you want me to send another one?

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
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160915/9197698c/attachment.sig>
