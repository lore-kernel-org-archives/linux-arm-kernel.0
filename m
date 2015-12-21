From: eric@anholt.net (Eric Anholt)
Date: Mon, 21 Dec 2015 14:41:41 -0800
Subject: [PATCH] pinctrl: bcm2835: Fix memory leak in error path
In-Reply-To: <1450658644-20858-1-git-send-email-stefan.wahren@i2se.com>
References: <1450658644-20858-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <87fuyvfmqi.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan Wahren <stefan.wahren@i2se.com> writes:

> In case of an invalid pin value bcm2835_pctl_dt_node_to_map()
> would leak the pull configs of already assigned pins.
> So avoid this by calling the free map function in error case.
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> Fixes: e1b2dc70cd5b ("pinctrl: add bcm2835 driver")

Reviewed-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151221/dfe30daf/attachment.sig>
