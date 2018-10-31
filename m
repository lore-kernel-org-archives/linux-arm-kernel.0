From: eric@anholt.net (Eric Anholt)
Date: Wed, 31 Oct 2018 10:16:20 -0700
Subject: [PATCH] firmware: raspberrypi: Define timeout for transactions
In-Reply-To: <1540922921-3653-1-git-send-email-stefan.wahren@i2se.com>
References: <1540922921-3653-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <87k1lyghp7.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan Wahren <stefan.wahren@i2se.com> writes:

> We should never assume to get a reply from the firmware otherwise
> the call could block forever and the user don't get informed. So
> define a timeout of 1 sec and print a stacktrace once in the unlikely
> case the timeout expired.
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Reviewed-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181031/94508108/attachment.sig>
