From: eric@anholt.net (Eric Anholt)
Date: Thu, 22 Sep 2016 09:42:57 +0300
Subject: [PATCH] clocksource: bcm2835_timer: Unmap region obtained by
 of_iomap
In-Reply-To: <1474479237-10356-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1474479237-10356-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <87vaxoa0zy.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arvind Yadav <arvind.yadav.cs@gmail.com> writes:

> Free memory mapping, if bcm2835_timer_init is not successful.
>
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Reviewed-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 800 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160922/72ec6b9b/attachment.sig>
