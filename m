From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 10 Oct 2014 20:30:13 +0200
Subject: [PATCH v3 0/5] ARM: sunxi: Add basic support for Allwinner A80 SoC
In-Reply-To: <5435F8EB.2040407@suse.de>
References: <1412773376-25212-1-git-send-email-wens@csie.org>
 <5435F8EB.2040407@suse.de>
Message-ID: <20141010183013.GQ19438@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Oct 09, 2014 at 04:54:35AM +0200, Andreas F?rber wrote:
> Hi,
> 
> Am 08.10.2014 um 15:02 schrieb Chen-Yu Tsai:
> > This is v3 of the initial Allwinner A80 support series.
> > This patch series adds very basic support for Allwinner's A80 SoC,
> > a big.LITTLE architecture with 4 Cortex-A7s and 4 Cortex-A15s.
> > 
> > Development is done on the A80 Optimus Board, the defacto development
> > board for the A80, with the accompanying SDK as a reference. 
> > 
> > So far I've been unable to get the board to boot from MMC, or
> > using Android fastboot. I'm using Allwinner's FEL mode to load
> > the bootloader and kernel+dtb image over USB. Notes on my attempts
> > can be found here: http://linux-sunxi.org/User:Wens#A80_Optimus
> 
> Tested-by: Andreas F?rber <afaerber@suse.de>
> 
> With this patch set on top of Maxime's sunxi-next branch, I get as far
> as searching for the rootfs.
> 
> CPUs 1-7 fail to boot with -38, which I guess is due to the vendor
> U-Boot not yet supporting PSCI.

That, and Linux not having some SMP bringup code either.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141010/35a88e5e/attachment.sig>
