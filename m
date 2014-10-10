From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 10 Oct 2014 20:26:23 +0200
Subject: [PATCH v3 0/5] ARM: sunxi: Add basic support for Allwinner A80 SoC
In-Reply-To: <1412773376-25212-1-git-send-email-wens@csie.org>
References: <1412773376-25212-1-git-send-email-wens@csie.org>
Message-ID: <20141010182623.GP19438@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 08, 2014 at 09:02:51PM +0800, Chen-Yu Tsai wrote:
> Hi everyone,
> 
> This is v3 of the initial Allwinner A80 support series.
> This patch series adds very basic support for Allwinner's A80 SoC,
> a big.LITTLE architecture with 4 Cortex-A7s and 4 Cortex-A15s.
> 
> Development is done on the A80 Optimus Board, the defacto development
> board for the A80, with the accompanying SDK as a reference. 
> 
> So far I've been unable to get the board to boot from MMC, or
> using Android fastboot. I'm using Allwinner's FEL mode to load
> the bootloader and kernel+dtb image over USB. Notes on my attempts
> can be found here: http://linux-sunxi.org/User:Wens#A80_Optimus
> 
> 
> Patch 1 introduces the compatible string for the A80.
> 
> Patch 2 adds a barebone dtsi with just the cpu, memory and uart nodes.
> 
> Patch 3 adds a barebone dts for the A80 Optimus Board.
> 
> Patch 4 documents all the Allwinner SoCs we currently support.
> 
> Patch 5 updates the sunxi README with a link to the A80's datasheet.

Applied all of them, thanks!

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141010/a2942ca8/attachment-0001.sig>
