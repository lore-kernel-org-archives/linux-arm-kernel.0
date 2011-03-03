From: ralf@linux-mips.org (Ralf Baechle)
Date: Thu, 3 Mar 2011 17:47:38 +0100
Subject: Memory Compaction feature.
In-Reply-To: <AANLkTikFHPYf74QNKYEQD2o+=VvZgVNGgbbydcUiF0WF@mail.gmail.com>
References: <AANLkTikFHPYf74QNKYEQD2o+=VvZgVNGgbbydcUiF0WF@mail.gmail.com>
Message-ID: <20110303164738.GA3863@linux-mips.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 03, 2011 at 06:32:35PM +0530, naveen yadav wrote:

[I changed the bogus linux-arm-kernel-request at lists.arm.linux.org.uk
address to linux-arm-kernel at lists.infradead.org.  I have no idea where
people keep pulling out -request addresses.]

> I want clarification is anybody verify this feature on ARM or MIPS architecture.
> 
> http://lwn.net/Articles/381677/

This got merged for 2.6.35 and as it doesn't tinker with architecture
specific code I assume it should just work on all architectures.  However
I have no reports of success or failure on MIPS.

  Ralf
