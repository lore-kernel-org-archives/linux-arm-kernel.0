From: afaerber@suse.de (=?windows-1252?Q?Andreas_F=E4rber?=)
Date: Thu, 09 Oct 2014 04:54:35 +0200
Subject: [PATCH v3 0/5] ARM: sunxi: Add basic support for Allwinner A80 SoC
In-Reply-To: <1412773376-25212-1-git-send-email-wens@csie.org>
References: <1412773376-25212-1-git-send-email-wens@csie.org>
Message-ID: <5435F8EB.2040407@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 08.10.2014 um 15:02 schrieb Chen-Yu Tsai:
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

Tested-by: Andreas F?rber <afaerber@suse.de>

With this patch set on top of Maxime's sunxi-next branch, I get as far
as searching for the rootfs.

CPUs 1-7 fail to boot with -38, which I guess is due to the vendor
U-Boot not yet supporting PSCI.

Thanks a lot for your work and help, Chen-Yu!

Regards,
Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141009/6f193c65/attachment.sig>
