From: albert.aribaud@free.fr (Albert ARIBAUD)
Date: Sat, 04 Sep 2010 19:12:16 +0200
Subject: Commit b2811c84e... breaks boot on net5big
Message-ID: <4C827DF0.6030801@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(sorry for any duplicates)

Net5big is a Marvell Orion 5281 based board I am in the process of 
adding a machine for -- almost there, except I recently rebased my work 
and the kernel now reboots before even outputting any log.

A bisect from v2.6.35-rc3 to current master of marvell tree points to 
commit b2811c84e... (reset PCIe unit on boot) as the cause of the kernel 
reboot.

Seeing as the commit is intended as a workaround for QNAP, could it be 
rewritten to be limited to the QNAP machine?

Amicalement,
-- 
Albert.
