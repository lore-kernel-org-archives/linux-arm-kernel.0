From: eric@anholt.net (Eric Anholt)
Date: Fri, 16 Nov 2018 13:23:13 -0800
Subject: [PATCH V2 0/3] ARM: dts: add Raspberry Pi 3 A+
In-Reply-To: <1542322805-6211-1-git-send-email-stefan.wahren@i2se.com>
References: <1542322805-6211-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <87a7m8d8e6.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan Wahren <stefan.wahren@i2se.com> writes:

> This patch series adds support for the brand new Raspberry Pi 3 A+ .
>
> Changes in V2:
> - add missing Makefile change for arm64
>
> Stefan Wahren (3):
>   dt-bindings: bcm: Add Raspberry Pi 3 A+
>   ARM: dts: add Raspberry Pi 3 A+
>   arm64: dts: broadcom: Add reference to RPi 3 A+

Looks pretty reasonable, but I couldn't verify any of the contents --
the firmware repo doesn't have a DT file for it, and the published
schematics don't show most of the GPIO connections (sigh).  How did you
write/test this?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181116/43b09e4b/attachment.sig>
