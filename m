From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 19 May 2010 15:16:32 +0800
Subject: [PATCH] ARM: Add support for 10 hardirq bits
In-Reply-To: <AANLkTil63uNv-S3D4ECYwT500w9sZd_8TE_T-SX0cqxv@mail.gmail.com>
References: <20100310111749.18521.9002.sendpatchset@t400s>
	<u2yaec7e5c31004292102rd561d7detc73e9fd2a5570ab0@mail.gmail.com>
	<20100501094436.GC12172@n2100.arm.linux.org.uk>
	<AANLkTil63uNv-S3D4ECYwT500w9sZd_8TE_T-SX0cqxv@mail.gmail.com>
Message-ID: <AANLkTikTCvOIbrr4TDt2OfHrHWHIFE4Cha8YhwtLrvc7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 13, 2010 at 3:30 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> On Sat, May 1, 2010 at 6:44 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Fri, Apr 30, 2010 at 01:02:04PM +0900, Magnus Damm wrote:
>>> On Wed, Mar 10, 2010 at 8:17 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
>>> > From: Magnus Damm <damm@opensource.se>
>>> >
>>> > This patch adds support for 10 hardirq bits to
>>> > the ARM architecture. Needed by the SH-Mobile
>>> > ARM processor sh7372 that has more than 512 IRQs.
>>> >
>>> > Signed-off-by: Magnus Damm <damm@opensource.se>
>>> > ---
>>> >
>>
>> I guess it's ok; with 10 bits we're at the maximum which the generic
>> kernel supports (see linux/hardirq.h)
>
> Hi again Russell,
>
> Will you pick up this one in your tree as-is, or would you like me to
> resubmit it somehow?
>

Russell,

I don't seem to find this patch in your -devel branch. I posted a same
version of patch earlier, so I'd also like to see this get merged.

Acked-by: Eric Miao <eric.y.miao@gmail.com>

Magnus,

I guess you may please help submit this to rmk's patch tracking system?
