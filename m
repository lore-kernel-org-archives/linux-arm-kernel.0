From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 04 Oct 2012 01:41:49 -0700
Subject: arm-soc maintainer entry
Message-ID: <506D4BCD.3020402@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Is the arm at kernel.org alias going to be added into the MAINTAINERS file?
Should anybody be sending mails to this address?

It seems I asked this over a year ago and the response was positive but
nothing ever happened[1]. Maybe something like below? I only ask because
get_maintainer.pl isn't picking up this email.

diff --git a/MAINTAINERS b/MAINTAINERS
index ecd8796..0e1ec23 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -606,6 +606,14 @@ W: http://www.arm.linux.org.uk/
 S:     Maintained
 F:     arch/arm/

+ARM SUB-ARCHITECTURES
+M:     arm at kernel.org
+L:     linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:     MAINTAINED
+F:     arch/arm/mach-*/
+F:     arch/arm/plat-*/
+T:     git git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
+
 ARM PRIMECELL AACI PL041 DRIVER
 M:     Russell King <linux@arm.linux.org.uk>
 S:     Maintained

[1] https://lkml.org/lkml/2011/7/26/307

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
