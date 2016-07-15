From: eric@anholt.net (Eric Anholt)
Date: Fri, 15 Jul 2016 11:58:32 -0700
Subject: [PATCH 2/3] watchdog: bcm2835_wdt: remove redundant ->set_timeout
 callback
In-Reply-To: <1468570524-18222-2-git-send-email-rasmus.villemoes@prevas.dk>
References: <1468570524-18222-1-git-send-email-rasmus.villemoes@prevas.dk>
 <1468570524-18222-2-git-send-email-rasmus.villemoes@prevas.dk>
Message-ID: <87shva919j.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rasmus Villemoes <rasmus.villemoes@prevas.dk> writes:

> bcm2835_wdt_set_timeout does exactly what the watchdog framework does
> in the absence of a ->set_timeout callback (see watchdog_set_timeout
> in watchdog_dev.c), so remove it.

These first two patches are:

Acked-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160715/4f832974/attachment-0001.sig>
