From: a.ryabinin@samsung.com (Andrey Ryabinin)
Date: Tue, 15 Jul 2014 10:56:59 +0400
Subject: [RFC/PATCH RESEND -next 10/21] mm: slab: share virt_to_cache()
 between slab and slub
In-Reply-To: <20140715055342.GH11317@js1304-P5Q-DELUXE>
References: <1404905415-9046-1-git-send-email-a.ryabinin@samsung.com>
 <1404905415-9046-11-git-send-email-a.ryabinin@samsung.com>
 <20140715055342.GH11317@js1304-P5Q-DELUXE>
Message-ID: <53C4D0BB.2020107@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/15/14 09:53, Joonsoo Kim wrote:
> On Wed, Jul 09, 2014 at 03:30:04PM +0400, Andrey Ryabinin wrote:
>> This patch shares virt_to_cache() between slab and slub and
>> it used in cache_from_obj() now.
>> Later virt_to_cache() will be kernel address sanitizer also.
> 
> I think that this patch won't be needed.
> See comment in 15/21.
> 

Ok, I'll drop it.

> Thanks.
> 
> 
