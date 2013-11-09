From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 9 Nov 2013 14:08:56 -0500
Subject: [PATCH 13/24] mm/power: Use memblock apis for early memory
 allocations
In-Reply-To: <1479529.EjZ9YN8f8I@vostro.rjw.lan>
References: <1383954120-24368-1-git-send-email-santosh.shilimkar@ti.com>
 <1383954120-24368-14-git-send-email-santosh.shilimkar@ti.com>
 <1479529.EjZ9YN8f8I@vostro.rjw.lan>
Message-ID: <527E8848.6030307@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 08 November 2013 08:30 PM, Rafael J. Wysocki wrote:
> On Friday, November 08, 2013 06:41:49 PM Santosh Shilimkar wrote:
>> Switch to memblock interfaces for early memory allocator instead of
>> bootmem allocator. No functional change in beahvior than what it is
>> in current code from bootmem users points of view.
>>
>> Archs already converted to NO_BOOTMEM now directly use memblock
>> interfaces instead of bootmem wrappers build on top of memblock. And the
>> archs which still uses bootmem, these new apis just fallback to exiting
>> bootmem APIs.
>>
>> Cc: Yinghai Lu <yinghai@kernel.org>
>> Cc: Tejun Heo <tj@kernel.org>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Pavel Machek <pavel@ucw.cz>
>> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
>> Cc: linux-pm at vger.kernel.org
>>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> Fine by me, thanks!
> 
Thanks Rafael. I take that as an ack.

Regards,
Santosh
