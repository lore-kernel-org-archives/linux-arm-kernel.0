From: axboe@fb.com (Jens Axboe)
Date: Wed, 28 Jan 2015 11:09:49 -0700
Subject: [PATCH] mtd: export new mtd_mmap_capabilities
In-Reply-To: <20150128180505.GW9759@ld-irv-0074>
References: <1900951.4yX9yJNQM5@wuerfel> <20150128180505.GW9759@ld-irv-0074>
Message-ID: <54C925ED.6000302@fb.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/28/2015 11:05 AM, Brian Norris wrote:
> On Wed, Jan 28, 2015 at 04:19:31PM +0100, Arnd Bergmann wrote:
>> The recently added mtd_mmap_capabilities can be used from loadable
>> modules, in particular romfs, but is not exported, so we get
>>
>> ERROR: "mtd_mmap_capabilities" [fs/romfs/romfs.ko] undefined!
>>
>> This adds the missing export.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> Fixes: b4caecd48005f ("fs: introduce f_op->mmap_capabilities for nommu mmap support")
>
> Acked-by: Brian Norris <computersforpeace@gmail.com>
>
> This should go through the block tree in which the target commit is
> queued.

Applied to for-3.20/bdi, thanks Arnd.

-- 
Jens Axboe
