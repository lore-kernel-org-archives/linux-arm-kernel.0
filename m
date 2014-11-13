From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 13 Nov 2014 01:21:40 +0100
Subject: [RESEND/PATCH] i2c: pxa: Use suspend() and resume() instead of
 the _noirq hooks
In-Reply-To: <7hzjcnaazl.fsf@deeprootsystems.com>
References: <1413829432-7815-1-git-send-email-ezequiel@vanguardiasur.com.ar>
 <7hzjcqe9ge.fsf@deeprootsystems.com>
 <54482EB1.9030407@vanguardiasur.com.ar>
 <7hzjcnaazl.fsf@deeprootsystems.com>
Message-ID: <20141113002139.GC2062@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> suspend/resume order depends on probe ordering, so with deferred probe,
> the probe ordering might be right, but it should be thoroughly tested.

Thanks a lot for the input here, Kevin!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141113/99d86d88/attachment-0001.sig>
