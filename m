From: netz.kernel@gmail.com (Marty Plummer)
Date: Fri, 26 Aug 2016 19:48:06 -0500
Subject: Older hisilicon chipsets
Message-ID: <7773f0e5-d045-1e93-529b-74a601467ed1@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greetings.

It has recently come to my mind to begin working on an updated firmware
for my employer's CCTV/DVR boxes, which are based around the Hi3520 line
of arm SoC.

In the process of learning which files I need to edit in order to
integrate my changes into the linux build system, I've come to find that
arch/arm/mach-hisi/{Kconfig,Makefile} covers no less than four different
chips from Hisilicon, and that seems to make it a bit awkward to insert
a whole new arch/arm/mach- directory for one single SoC and create
duplicate menuitems for Hisilicon.

So, I'm wondering whereabouts I should place the data for the chips that
I am working on, for the sake of organization and whatnot.

Also, I've been having difficulty getting a response from Hisilicon
regarding my request for source code for this and a few other of their
chips running in our other, newer DVRs, even though a cursory
examination after accessing the devices via telnet shows they do in fact
run a busybox/linux/uClibc based system, with a number of GPL licensed
libraries and kernel modules.

Regards,
	Marty

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160826/222521ef/attachment.sig>
