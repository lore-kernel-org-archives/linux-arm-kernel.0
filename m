From: smoch@web.de (Soeren Moch)
Date: Thu, 17 Jan 2013 14:47:23 +0100
Subject: [PATCH v2] mm: dmapool: use provided gfp flags for all
 dma_alloc_coherent() calls
In-Reply-To: <201301171049.30415.arnd@arndb.de>
References: <20121119144826.f59667b2.akpm@linux-foundation.org>
 <20130116024014.GH25500@titan.lakedaemon.net> <50F61D86.4020801@web.de>
 <201301171049.30415.arnd@arndb.de>
Message-ID: <50F800EB.6040104@web.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17.01.2013 11:49, Arnd Bergmann wrote:
> On Wednesday 16 January 2013, Soeren Moch wrote:
>>>> I will see what I can do here. Is there an easy way to track the buffer
>>>> usage without having to wait for complete exhaustion?
>>>
>>> DMA_API_DEBUG
>>
>> OK, maybe I can try this.
>>>
>
> Any success with this? It should at least tell you if there is a
> memory leak in one of the drivers.

Not yet, sorry. I have to do all the tests in my limited spare time.
Can you tell me what to search for in the debug output?

Soeren
