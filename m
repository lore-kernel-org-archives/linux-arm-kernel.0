From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 21 Jun 2011 11:26:00 +0100
Subject: [RFC PATCH] ARM: smp: Fix the CPU hotplug race with scheduler.
In-Reply-To: <4E00708C.6050108@ti.com>
References: <20110620111336.GG2082@n2100.arm.linux.org.uk>
	<4DFF2E37.8030602@ti.com>
	<20110620114019.GH2082@n2100.arm.linux.org.uk>
	<20110620142338.GL2082@n2100.arm.linux.org.uk>
	<4DFF5F29.2000904@ti.com> <4E005F92.8030208@ti.com>
	<20110621100057.GB23802@n2100.arm.linux.org.uk>
	<4E006FA0.7050508@ti.com>
	<20110621101900.GC23802@n2100.arm.linux.org.uk>
	<4E00708C.6050108@ti.com>
Message-ID: <20110621102600.GD23802@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2011 at 03:51:00PM +0530, Santosh Shilimkar wrote:
> On 6/21/2011 3:49 PM, Russell King - ARM Linux wrote:
>> On Tue, Jun 21, 2011 at 03:47:04PM +0530, Santosh Shilimkar wrote:
>
> [...]
>
>>>> I already have that as a separate change.
>>> Can you point me to both of these commits so that I have
>>> them in my tree for testing.
>>
>> I won't be committing the init/calibrate.c change to a git tree - it
>> isn't ARM stuff so it goes in patch form.
>
> Patches with change log would be fine as well.

The answer is not at the moment, but maybe soon.
