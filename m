From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 4 Jan 2018 14:41:30 +0100
Subject: [PATCH v3 09/11] clk: sunxi-ng: add support for Allwinner A64
 DE2 CCU
In-Reply-To: <20171222122243.25735-10-icenowy@aosc.io>
References: <20171222122243.25735-1-icenowy@aosc.io>
 <20171222122243.25735-10-icenowy@aosc.io>
Message-ID: <20180104134130.dfh2qbhcvo67zu36@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 22, 2017 at 08:22:41PM +0800, Icenowy Zheng wrote:
> Allwinner A64's DE2 needs to claim a section of SRAM (SRAM C) to work.
> 
> Add support for it.

That's highly suspicious that the clocks need an SRAM to operate
properly.

Can you elaborate?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180104/be08db2b/attachment.sig>
