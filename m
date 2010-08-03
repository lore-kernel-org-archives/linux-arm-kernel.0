From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 3 Aug 2010 14:07:21 +0900
Subject: [PATCH] ARM: clean files in arch/arm/boot/compressed/
In-Reply-To: <20100727113706.GB11468@n2100.arm.linux.org.uk>
References: <20100727092921.3620.51711.sendpatchset@t400s>
	<20100727113706.GB11468@n2100.arm.linux.org.uk>
Message-ID: <AANLkTimrV3-FHuqjsUSrAziG4Y=Ty39kzu1e8dVMKJ5_@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

[CC Paul Mundt]

On Tue, Jul 27, 2010 at 8:37 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Jul 27, 2010 at 06:29:21PM +0900, Magnus Damm wrote:
>> From: Magnus Damm <damm@opensource.se>
>>
>> Update the compressed boot Makefile for ARM to
>> remove files during clean.
>>
>> Signed-off-by: Magnus Damm <damm@opensource.se>
>> ---
>>
>> ?Perhaps there is a better way to do this?
>
> That'll do - can you stick it in the patch system please, and I'll try
> to get it in before 2.6.35 is released.

Done! My patches covering files outside arch/arm/mach-shmobile/ have
all been submitted.

There are quite a few SH-Mobile changes in the genesis-2.6 git tree as
well. You and Paul Mundt dealt with that tree last time. How is that
coming along? Do you prefer to take things through the patch tracker
instead?

Thanks for your help!

Cheers,

/ magnus
