From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 8 Dec 2015 09:11:17 +0100
Subject: [PATCH v5 1/4] clk: sunxi: Add H3 clocks support
In-Reply-To: <1449264283-25360-2-git-send-email-jenskuske@gmail.com>
References: <1449264283-25360-1-git-send-email-jenskuske@gmail.com>
 <1449264283-25360-2-git-send-email-jenskuske@gmail.com>
Message-ID: <20151208081117.GL27957@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jens,

On Fri, Dec 04, 2015 at 10:24:40PM +0100, Jens Kuske wrote:
> The H3 clock control unit is similar to the those of other sun8i family
> members like the A23.
> 
> It adds a new bus gates clock similar to the simple gates, but with a
> different parent clock for each single gate.
> Some of the gates use the new AHB2 clock as parent, whose clock source
> is muxable between AHB1 and PLL6/2. The documentation isn't totally clear
> about which devices belong to AHB2 now, especially USB EHIC/OHIC, so it
> is mostly based on Allwinner kernel source code.
> 
> Signed-off-by: Jens Kuske <jenskuske@gmail.com>

Applied, thanks!

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151208/ad73f984/attachment.sig>
