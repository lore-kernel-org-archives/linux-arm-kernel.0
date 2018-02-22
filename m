From: eric@anholt.net (Eric Anholt)
Date: Thu, 22 Feb 2018 12:12:23 -0800
Subject: [PATCH v4] ARM: dts: bcm283x: Fix pin function of JTAG pins
In-Reply-To: <1516243293-25010-1-git-send-email-henryzhang62@gmail.com>
References: <1516243293-25010-1-git-send-email-henryzhang62@gmail.com>
Message-ID: <87y3jk942g.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

henryzhang62 at gmail.com writes:

> From: Henry Zhang <henryzhang62@gmail.com>
>
> BCM2835 ARM Peripherals doc shows gpio pins 4, 5, 6, 12 and 13
> carry altenate function, ALT5 for ARM JTAG
>
> Fixes: 21ff843931b2 ("ARM: dts: bcm283x: Define standard pinctrl groups in the gpio node.")
>
> Signed-off-by: Henry Zhang <henryzhang62@gmail.com>
> Acked-by: Stefan Wahren <stefan.wahren@i2se.com>

Applied to bcm2835-dt-next.  Thanks!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180222/18c0cc5c/attachment.sig>
