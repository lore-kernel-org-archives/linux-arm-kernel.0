From: morten.rasmussen@arm.com (Morten Rasmussen)
Date: Mon, 3 Feb 2014 15:03:22 +0000
Subject: about last level cache on big little cpu
In-Reply-To: <52EFACDC.7090103@linaro.org>
References: <52EFACDC.7090103@linaro.org>
Message-ID: <20140203150322.GC18860@e103034-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 03, 2014 at 02:51:08PM +0000, Alex Shi wrote:
> Does all the big.LITTLE cpu share the same llc? or it depends on
> different vendor's products?

No. I don't know of any big.LITTLE implementation that does have a
shared last level cache. TC2 has per cluster L2 caches as last level
caches, so no cache is shared between the big and little clusters.

Morten
