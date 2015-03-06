From: davem@davemloft.net (David Miller)
Date: Fri, 06 Mar 2015 15:18:30 -0500 (EST)
Subject: [PATCH v3 0/2] net/macb: merge at91_ether driver into macb driver
In-Reply-To: <1425638921-9768-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1425638921-9768-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20150306.151830.2271015374667204230.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Fri,  6 Mar 2015 11:48:39 +0100

> Changes since v2:
> - rebase after changed brought by [1]

Ugh, actually I'm tossing all of your changes.  Please do not make
complex dependencies like this.

And furthermore, don't reference other sets of changes via lkml
postings.  Reference them by where they are in patchwork which is
the definitive location for networking patch submissions.
