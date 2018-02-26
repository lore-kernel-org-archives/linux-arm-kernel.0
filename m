From: eric@anholt.net (Eric Anholt)
Date: Mon, 26 Feb 2018 15:31:48 -0800
Subject: [PATCH 4/4] ARM: bcm2385_defconfig: Enable BT support for BCM43438
In-Reply-To: <1519567855-26105-5-git-send-email-stefan.wahren@i2se.com>
References: <1519567855-26105-1-git-send-email-stefan.wahren@i2se.com>
 <1519567855-26105-5-git-send-email-stefan.wahren@i2se.com>
Message-ID: <87o9kbjpjv.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan Wahren <stefan.wahren@i2se.com> writes:

> The Raspberry Pi Zero W has an onboard BT chip (BCM43438). So enable the
> necessary HCI UART driver (requires serial device bus).
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Applied patches 2-4 to bcm2835-dt-next and bcm2835-defconfig-next.
Thanks!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180226/d561a6d1/attachment.sig>
