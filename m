From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 4 Dec 2013 09:58:05 -0500
Subject: [PATCH v2 02/23] mm/memblock: debug: don't free reserved array
 if !ARCH_DISCARD_MEMBLOCK
In-Reply-To: <20131203225258.GS8277@htj.dyndns.org>
References: <1386037658-3161-1-git-send-email-santosh.shilimkar@ti.com>
 <1386037658-3161-3-git-send-email-santosh.shilimkar@ti.com>
 <20131203225258.GS8277@htj.dyndns.org>
Message-ID: <529F42FD.5020704@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 03 December 2013 05:52 PM, Tejun Heo wrote:
> On Mon, Dec 02, 2013 at 09:27:17PM -0500, Santosh Shilimkar wrote:
> ...
>> Cc: Yinghai Lu <yinghai@kernel.org>
>> Cc: Tejun Heo <tj@kernel.org>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> Reviewed-by: Tejun Heo <tj@kernel.org>
> 
>> +	/*
>> +	 * Don't allow Nobootmem allocator to free reserved memory regions
> 
> Extreme nitpick: why the capitalization of "Nobootmem"?
> 
Will fix that
