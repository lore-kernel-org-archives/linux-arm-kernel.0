From: eric@anholt.net (Eric Anholt)
Date: Wed, 17 Feb 2016 20:19:09 -0800
Subject: [PATCH V2 5/8] dmaengine: bcm2835: move cyclic member from
 bcm2835_chan into bcm2835_desc
In-Reply-To: <1452187987-2605-6-git-send-email-kernel@martin.sperl.org>
References: <1452187987-2605-1-git-send-email-kernel@martin.sperl.org>
 <1452187987-2605-6-git-send-email-kernel@martin.sperl.org>
Message-ID: <87twl6wszm.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kernel at martin.sperl.org writes:

> From: Martin Sperl <kernel@martin.sperl.org>
>
> In preparation to consolidating code we move the cyclic member
> into the bcm_2835_desc structure.

Reviewed-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160217/b9f7c7f9/attachment.sig>
