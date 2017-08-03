From: eric@anholt.net (Eric Anholt)
Date: Thu, 03 Aug 2017 14:23:29 -0700
Subject: [PATCH V2 0/3] ARM: bcm283x: Raspberry Pi Zero W support
In-Reply-To: <1501434634-2325-1-git-send-email-stefan.wahren@i2se.com>
References: <1501434634-2325-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <87d18cxs4u.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan Wahren <stefan.wahren@i2se.com> writes:

> This patch series adds support for the Raspberry Pi Zero W. It depends
> on "V2 ARM: dts: bcm283x: Move the BCM2837 DT contents from arm64 to arm."
>
> Currently there is a regression [1] in the brcmfmac driver. This hack [2]
> avoids the issue and make wifi probe on RPi Zero W.
>
> Changes in V2:
> - add aliases comment and gpio-line-names into bcm2835-rpi-zero-w.dts
> - rebased on V2 of arm64 to arm patch
>
> [1] - http://marc.info/?l=linux-wireless&m=150029709021719&w=2
> [2] - https://github.com/lategoodbye/rpi-zero/commit/95ef5b8fbc05d9ec086970648767cafa10483622

Reviewed and pushed to my dt-next, will try to get a PR out soon.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170803/d94a5ac2/attachment.sig>
