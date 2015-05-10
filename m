From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 10 May 2015 12:17:50 +0200
Subject: [PATCH 3/6] clk: sunxi: Add A33 clock for compilation
In-Reply-To: <1431240383-12763-4-git-send-email-vishnupatekar0510@gmail.com>
References: <1431240383-12763-1-git-send-email-vishnupatekar0510@gmail.com>
 <1431240383-12763-4-git-send-email-vishnupatekar0510@gmail.com>
Message-ID: <20150510101750.GC11057@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, May 10, 2015 at 12:16:20PM +0530, Vishnu Patekar wrote:
> A33 clock control unit is similar to A23.
> 
> A33 specific clocks are not yet implemented, added CLK_OF_DECLARE
> to get it compiled for A33.

That commit log doesn't make any sense.

What you're doing isn't about whether or not that will be compiled,
but whether you're registering the clocks and which clocks you
protect.

> Signed-off-by: VishnuPatekar <vishnupatekar0510@gmail.com>

Isn't it supposed to have a space in the middle of your name, just
like you have in your mail address?

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150510/1c1b96da/attachment.sig>
