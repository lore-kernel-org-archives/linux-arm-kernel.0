From: eric.y.miao@gmail.com (Eric Miao)
Date: Sat, 22 May 2010 11:34:16 +0800
Subject: [RFC PATCH v2] preliminary support for sparse IRQ
In-Reply-To: <20100521194654.GH11042@n2100.arm.linux.org.uk>
References: <AANLkTikSXcn9nnvaVHAsoDPmLN30E_TjNVdXu1vCOH74@mail.gmail.com>
	<20100520082853.GA18885@linux-sh.org>
	<20100521194654.GH11042@n2100.arm.linux.org.uk>
Message-ID: <AANLkTim73Y7LB33mg3_P7v4-22cwpFMRaprI828YvvkE@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 22, 2010 at 3:46 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, May 20, 2010 at 05:28:53PM +0900, Paul Mundt wrote:
>> On Tue, May 18, 2010 at 06:34:49PM +0800, Eric Miao wrote:
>> > commit 2e2e087d96630c95dbce57036680cf917e906cf1
>> > Author: Eric Miao <eric.y.miao@gmail.com>
>> > Date: ? Mon Dec 28 12:59:59 2009 +0800
>> >
>> > ? ? [ARM] preliminary support for sparse IRQ
>> >
>> > ? ? So to allow NR_IRQS to be dynamic and platforms to specify the number
>> > ? ? of IRQs really needed.
>> >
>> > ? ? Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
>> >
>> It would be nice to see this applied, we plan to use sparseirq
>> unconditionally for shmobile (as sh already does).
>
> However, it's a little late in the day for patches for this merge
> window - which could be over as early as Sunday.
>
> However, if Eric wants to submit it to the patch system, I'll see
> about queuing it, but I can't make any promises that it'll get in.
>

I'll send it to your patch tracking system, but we can leave it for the
next merge window. I have some other patches depending on this.
