From: eric@anholt.net (Eric Anholt)
Date: Fri, 15 Dec 2017 13:53:17 -0800
Subject: [PATCH 1/3] dt-bindings: bcm2836-l1-intc: add interrupt polarity
 support
In-Reply-To: <1513024752-11246-2-git-send-email-stefan.wahren@i2se.com>
References: <1513024752-11246-1-git-send-email-stefan.wahren@i2se.com>
 <1513024752-11246-2-git-send-email-stefan.wahren@i2se.com>
Message-ID: <87y3m3mzea.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan Wahren <stefan.wahren@i2se.com> writes:

> This increases the interrupt cells for the 1st level interrupt controller
> binding in order to describe the polarity like on the other ARM platforms.
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

I'm happy with this.  Any DT maintainer concerns?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171215/46a79d48/attachment.sig>
