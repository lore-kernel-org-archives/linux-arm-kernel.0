From: tony@atomide.com (Tony Lindgren)
Date: Fri, 26 Feb 2010 15:36:15 -0800
Subject: [PATCH 7/6] omap2: Initialize Menelaus and MMC for N8X0
In-Reply-To: <20100225230116.26233.65157.stgit@baageli.muru.com>
References: <20100225230116.26233.65157.stgit@baageli.muru.com>
Message-ID: <20100226233615.GG17041@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's one more to initialize the MMC on N8X0. That's handy
for boot testing the multi-omap kernels on 24xx.

For some reason only one of the MMC slots seems to work
on both N800 and N810 for some reason. No idea why, the
Menelaus slot switching seems to be all there.

Regards,

Tony
-------------- next part --------------
A non-text attachment was scrubbed...
Name: n8x0-mmc.patch
Type: text/x-diff
Size: 11133 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100226/6756f391/attachment.bin>
