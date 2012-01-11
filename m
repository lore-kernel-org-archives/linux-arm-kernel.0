From: ospite@studenti.unina.it (Antonio Ospite)
Date: Wed, 11 Jan 2012 01:45:52 +0100
Subject: Adding support for DoC G3 on Motorola A780, some help needed.
Message-ID: <20120111014552.0dca6f3e34e2f24cf3a58f0f@studenti.unina.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robert, LAK folks,

I saw that a driver for the DoC G3 NAND chip has been added to linux-3.2
(and write support is coming to 3.3, right?); some EZX phones like the
Motorola A780 and E680 supported by OpenEZX[1] are using this chip
AFAWK, but they also come with a NOR chip[2].

Can you please give me some directions about adding support for the
docg3 to the A780? The changes will look somewhat similar to the
ones for the MIOA701[3], but we have the NOR too and I have some doubts.

My questions are:
  - How can I find out the resource to use? I can telnet to the
    original firmware using linux-2.4.
  - What are the __raw_writel() calls in [3] for?
  - How are the partitions specified with the docg3 driver?

Thanks a lot,
   Antonio

[1] http://openezx.org
[2] http://cgit.openezx.org/openezx/tree/arch/arm/mach-pxa/ezx.c?h=ezx/current#n1067
[3] http://thread.gmane.org/gmane.linux.ports.arm.kernel/144806

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120111/0988d58c/attachment.sig>
