From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 10 Apr 2017 09:04:54 +0200
Subject: [PATCH 2/2] clk: sunxi-ng: fix PRCM CCU CLK_NUMBER value
In-Reply-To: <20170407161904.32624-2-icenowy@aosc.io>
References: <20170407161904.32624-1-icenowy@aosc.io>
 <20170407161904.32624-2-icenowy@aosc.io>
Message-ID: <20170410070454.6sm2qowqtlxdafws@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 08, 2017 at 12:19:04AM +0800, Icenowy Zheng wrote:
> The CLK_NUMBER value of PRCM CCU is wrongly set to (CLK_APB0_PWD + 1),
> which prevented the IR mod clock from being set up.
> 
> Change it to (CLK_IR + 1) in order to correctly get IR mod set up.

Applied both, thanks.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170410/316bf0c2/attachment-0001.sig>
