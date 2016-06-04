From: eric@anholt.net (Eric Anholt)
Date: Fri, 03 Jun 2016 17:02:16 -0700
Subject: [PATCH 2/2] mmc: sdhci-bcm2835: remove driver
In-Reply-To: <1464983233-27001-3-git-send-email-stefan.wahren@i2se.com>
References: <1464983233-27001-1-git-send-email-stefan.wahren@i2se.com>
 <1464983233-27001-3-git-send-email-stefan.wahren@i2se.com>
Message-ID: <87inxp7ref.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan Wahren <stefan.wahren@i2se.com> writes:

> The sdhci-bcm2835 is no more needed since it has been replaced
> by sdhci-iproc.

We've had a cycle to catch regressions from the merged driver, so I'm
happy to see the old one go.  Thanks Stefan!

Acked-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160603/95f6fb38/attachment-0001.sig>
