From: eric@anholt.net (Eric Anholt)
Date: Mon, 28 Mar 2016 11:42:28 -0700
Subject: [PATCH] pinctrl: bcm2835: Implement get_direction callback
In-Reply-To: <1459177104-24353-1-git-send-email-stefan.wahren@i2se.com>
References: <1459177104-24353-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <87y492jvfv.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan Wahren <stefan.wahren@i2se.com> writes:

> Implement gpio_chip's get_direction() callback, that lets other
> drivers get particular GPIOs direction using gpiod_get_direction().

Reviewed-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160328/e2b2a259/attachment.sig>
