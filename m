From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 24 Sep 2014 08:41:24 +0200
Subject: [PATCH 0/6] ARM: sunxi: Add basic support for Allwinner A80 SoC
In-Reply-To: <1411311493-24344-1-git-send-email-wens@csie.org>
References: <1411311493-24344-1-git-send-email-wens@csie.org>
Message-ID: <20140924064124.GS15315@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chen-Yu,

On Sun, Sep 21, 2014 at 10:58:07PM +0800, Chen-Yu Tsai wrote:
> Hi everyone,
> 
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

It looks very nice, thanks a lot. You'll find a minor comments inline.

One thing I forgot to ask you about when doing the A23, and that would
nice to do is to update the documentation we have in
Documentation/arm/sunxi/README with the A23 and A80 infos you've been
able to gather.

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
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140924/fbe60b6c/attachment.sig>
