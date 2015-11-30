From: eric@anholt.net (Eric Anholt)
Date: Mon, 30 Nov 2015 09:17:36 -0800
Subject: [PATCH] pinctrl: bcm2835: Fix initial value for direction_output
In-Reply-To: <1447893147-9458-1-git-send-email-stefan.wahren@i2se.com>
References: <1447893147-9458-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <87r3j7tnin.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan Wahren <stefan.wahren@i2se.com> writes:

> Currently the provided initial value for bcm2835_gpio_direction_output
> has no effect. So fix this issue by changing the value before
> changing the GPIO direction. As a result we need to move the function below
> bcm2835_gpio_set.
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> CC: Martin Sperl <kernel@martin.sperl.org>
> CC: Stephen Warren <swarren@wwwdotorg.org>

Acked-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151130/0a065946/attachment.sig>
