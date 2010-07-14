From: minchan.kim@gmail.com (Minchan Kim)
Date: Wed, 14 Jul 2010 20:04:07 +0900
Subject: About SECTION_SIZE_BITS for Sparsemem
In-Reply-To: <20100714084943.GA9115@n2100.arm.linux.org.uk>
References: <000601cb219c$c7830b60$56892220$%kim@samsung.com>
	<AANLkTinTrt7VKuKvleiJj4lv2tWqCcDYHVXAQIHLA7bh@mail.gmail.com>
	<001b01cb21aa$ef0e4d80$cd2ae880$%kim@samsung.com>
	<AANLkTinkujX3VbL0sXjjghovr8eX9Os0huw3OTBut2UP@mail.gmail.com>
	<20100713092658.GB29885@csn.ul.ie>
	<20100713093815.GD20590@n2100.arm.linux.org.uk>
	<20100713095035.GE29885@csn.ul.ie>
	<20100713173744.GB30142@n2100.arm.linux.org.uk>
	<20100713203250.GA21600@csn.ul.ie>
	<AANLkTim55BDz4_vWhTnDVj1EP42MxAMZzP2PR80j5fLN@mail.gmail.com>
	<20100714084943.GA9115@n2100.arm.linux.org.uk>
Message-ID: <AANLkTilrLJb97NkK4Q-Oan_ufXRdafIw7n6060mItaXj@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 14, 2010 at 5:49 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Jul 14, 2010 at 08:59:06AM +0900, Minchan Kim wrote:
>> But I think Kukjin case's best solution is to make section size 16M, not 256M.
>> Regardless of this, Your idea is the direction we should proceed, I think.
>
> So what if someone decides to fit 8MB DRAMs to the board?
>

Hmm. It might be a problem.
Should we consider all configuration?

Then, in below cases ram size never can change?
How does it acked and merged?
I don't know below board can't configurable ram size. Just out of curiosity.


   #   line  filename / context / line
   1     76  arch/arm/mach-clps711x/include/mach/memory.h <<SECTION_SIZE_BITS>>
             #define SECTION_SIZE_BITS 24
   2     26  arch/arm/mach-lh7a40x/include/mach/memory.h <<SECTION_SIZE_BITS>>
             #define SECTION_SIZE_BITS 24
   3     62  arch/arm/mach-realview/include/mach/memory.h <<SECTION_SIZE_BITS>>
             #define SECTION_SIZE_BITS 28
   4     38  arch/arm/mach-rpc/include/mach/memory.h <<SECTION_SIZE_BITS>>
             #define SECTION_SIZE_BITS 26
   5     21  arch/arm/mach-s5pv210/include/mach/memory.h <<SECTION_SIZE_BITS>>
             #define SECTION_SIZE_BITS 28
   6     46  arch/arm/mach-sa1100/include/mach/memory.h <<SECTION_SIZE_BITS>>
             #define SECTION_SIZE_BITS 27
   7     19  drivers/staging/msm/memory_ll.h <<SECTION_SIZE_BITS>>
             #define SECTION_SIZE_BITS 25





-- 
Kind regards,
Minchan Kim
