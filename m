From: minchan.kim@gmail.com (Minchan Kim)
Date: Thu, 26 Aug 2010 13:06:28 +0900
Subject: [PATCH/RFCv4 0/6] The Contiguous Memory Allocator framework
In-Reply-To: <20100826124434.6089630d.kamezawa.hiroyu@jp.fujitsu.com>
References: <cover.1282286941.git.m.nazarewicz@samsung.com>
	<1282310110.2605.976.camel@laptop>
	<20100825155814.25c783c7.akpm@linux-foundation.org>
	<20100826095857.5b821d7f.kamezawa.hiroyu@jp.fujitsu.com>
	<op.vh0wektv7p4s8u@localhost>
	<20100826115017.04f6f707.kamezawa.hiroyu@jp.fujitsu.com>
	<20100826124434.6089630d.kamezawa.hiroyu@jp.fujitsu.com>
Message-ID: <AANLkTi=T1y+sQuqVTYgOkYvqrxdYB1bZmCpKafN5jPqi@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 26, 2010 at 12:44 PM, KAMEZAWA Hiroyuki
<kamezawa.hiroyu@jp.fujitsu.com> wrote:
> On Thu, 26 Aug 2010 11:50:17 +0900
> KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:
>
>> 128MB...too big ? But it's depend on config.
>>
>> IBM's ppc guys used 16MB section, and recently, a new interface to shrink
>> the number of /sys files are added, maybe usable.
>>
>> Something good with this approach will be you can create "cma" memory
>> before installing driver.
>>
>> But yes, complicated and need some works.
>>
> Ah, I need to clarify what I want to say.
>
> With compaction, it's helpful, but you can't get contiguous memory larger
> than MAX_ORDER, I think. To get memory larger than MAX_ORDER on demand,
> memory hot-plug code has almost all necessary things.

True. Doesn't patch's idea of Christoph helps this ?
http://lwn.net/Articles/200699/


-- 
Kind regards,
Minchan Kim
