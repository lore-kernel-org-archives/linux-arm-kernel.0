From: eric@anholt.net (Eric Anholt)
Date: Thu, 25 Aug 2016 15:45:14 -0700
Subject: [PATCH V3 0/5] ARM: dts: bcm2835: Add Raspberry Pi Zero
In-Reply-To: <1471792204-21908-1-git-send-email-stefan.wahren@i2se.com>
References: <1471792204-21908-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <87oa4gv56t.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan Wahren <stefan.wahren@i2se.com> writes:

> This patch series add support for Raspberry Pi Zero with USB host mode. It's
> based on the patch "ARM64: dts: bcm: Use a symlink to R-Pi dtsi files
> from arch=arm" from Ian Campbell. Currently there is a bug [1] which needs
> to fixed before because after applying these patch series the bug isn't
> reproducible anymore but not fixed.
>
> The patches 1-3 fixes the USB DT settings for bcm283x. Patch 3 is only compile
> tested, so it would be nice if someone with a RPi 3 could test it.
> The last patch based on the work of Lubomir Rintel [2] and Noralf Tr?nnes [3].
>
> Note: Patch 3 can't be cherry-picked because it depends on Patch 2.

Pulled this series minus the arm64 patch to bcm2835-dt-next.  My Pi3
setup is down currently so I wasn't able to test it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 800 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160825/7609b790/attachment.sig>
