From: omar.ramirez@ti.com (Ramirez Luna, Omar)
Date: Wed, 2 Nov 2011 10:24:49 -0500
Subject: [PATCH v3 4/4] OMAP3/4: iommu: adapt to runtime pm
In-Reply-To: <20111102152116.GB14916@n2100.arm.linux.org.uk>
References: <1320185752-568-1-git-send-email-omar.ramirez@ti.com>
	<1320185752-568-5-git-send-email-omar.ramirez@ti.com>
	<20111102152116.GB14916@n2100.arm.linux.org.uk>
Message-ID: <CAB-zwWhX5ayyG-Tz7rT4=gG-WZTpHEQskq50MMgPv8bj0VMiGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 2, 2011 at 10:21 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Nov 01, 2011 at 05:15:52PM -0500, Omar Ramirez Luna wrote:
>> Use runtime PM functionality interfaced with hwmod enable/idle
>> functions, to replace direct clock operations, reset and sysconfig
>> handling.
>>
>> Tidspbridge uses a macro removed with this patch, for now the value
>> is hardcoded to avoid breaking compilation.
>
> You probably want to include people involved with power management on
> this, so maybe the linux-pm mailing list, and those involved with
> runtime-pm stuff (I think Rafael qualifies as the maintainer for this
> stuff, even if he's not listed in MAINTAINERS.)

Will do, I'll submit it again if no other comments are received.

Regards,

Omar
