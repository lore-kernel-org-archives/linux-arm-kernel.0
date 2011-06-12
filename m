From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sun, 12 Jun 2011 02:06:37 -0400
Subject: [PATCH 0/3] patches to allow DTB to be appended to the ARM zImage
Message-ID: <1307858800-16712-1-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a resend of those patches with fixups after the latest changes
in mainline.

[PATCH 1/3] ARM: zImage: ensure it is always a multiple of 64 bits in size
This one is new and trivial.

[PATCH 2/3] ARM: zImage: Allow the appending of a device tree binary
Mostly John Bonesio's version with some adjustments and cleanups.

[PATCH 3/3] ARM: zImage: make sure appended DTB doesn't get overwritten by kernel .bss
New, simpler alternative to Tony Lindgren's version.


Nicolas
