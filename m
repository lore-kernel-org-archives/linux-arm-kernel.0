From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Mar 2012 16:39:38 +0000
Subject: linux-next: build failure after merge of the final tree (arm-soc
 tree related)
In-Reply-To: <20120315002020.GA16189@titan.lakedaemon.net>
References: <20120315105901.7b10c9f4de9374a613436988@canb.auug.org.au>
 <20120315002020.GA16189@titan.lakedaemon.net>
Message-ID: <201203151639.38223.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 March 2012, Jason Cooper wrote:
> That's my mistake.  I did a pull request for the wrong branch.  Olof,
> could you please drop the offending branch and I'll submit a new pull
> request once I have a chance to test Arnd's irq patch?

I reverted this in the for-next branch for now. The two initial patches
from the kirkwood/board branch are still present.

	Arnd
