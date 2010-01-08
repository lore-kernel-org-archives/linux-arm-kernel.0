From: jvermillard@archean.fr (Julien Vermillard)
Date: Fri, 8 Jan 2010 10:08:05 +0100
Subject: S3C2440 : DM9000 link down when writing on NAND flash
Message-ID: <20100108100805.15e4b558@jvermillard-portable>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
I'm using a DM9000E with a S3C2440 CPU running 2.6.30.1. The DM9K is
connected on the CS4 (like the mini2440). I already had troubles with
the ethernet, and we applied (as suggested here) the DM900 errata
consisting in gating IOR & CS. The DM9000 is working better now, but
when I write some file on the NAND Flash, the DM900 is reseting (link
down, link up). Reading from NAND flash is fine.

If I put the whole rootfs in the SD card, I have no problems.

Here the schematics of the DM9000 and how it's plugged on the CPU :
http://people.apache.org/~jvermillard/atsarm9/

Any suggestion ?

Julien
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 197 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100108/187907b3/attachment.sig>
