From: eric@anholt.net (Eric Anholt)
Date: Tue, 02 Feb 2016 17:34:19 -0800
Subject: [PATCH V3 1/4] ARM: bcm2835: follow dt uart node-naming convention
In-Reply-To: <1453032932-2512-2-git-send-email-kernel@martin.sperl.org>
References: <1453032932-2512-1-git-send-email-kernel@martin.sperl.org>
 <1453032932-2512-2-git-send-email-kernel@martin.sperl.org>
Message-ID: <871t8ur2zo.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kernel at martin.sperl.org writes:

> From: Martin Sperl <kernel@martin.sperl.org>
>
> This patch fixes the naming of the device tree node: uart at 7e201000
> to conform to the standard of: serial at 7e201000
>
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>

Did the rebase and merged this one to bcm2835-dt-next.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160202/210a2996/attachment.sig>
