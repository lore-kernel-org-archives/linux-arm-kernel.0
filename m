From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 19 Mar 2012 18:39:11 +1100
Subject: linux-next: build warning after merge of the arm-soc tree
Message-ID: <20120319183911.0cd46df560c714ee71184242@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

After merging the arm-soc tree, today's linux-next build (all)
produced this warning:

drivers/clk/Kconfig:22: warning: menuconfig statement without prompt

Introduced by commit c173033d154e ("clk: make CONFIG_COMMON_CLK invisible").

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120319/10de77d0/attachment-0001.sig>
