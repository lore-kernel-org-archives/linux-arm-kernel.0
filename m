From: saeed.bishara@gmail.com (saeed bishara)
Date: Sat, 28 Nov 2009 10:04:06 +0200
Subject: [PATCH 1/3] ARM: add base support for Marvell Dove SoC
In-Reply-To: <alpine.LFD.2.00.0911271547110.2059@xanadu.home>
References: <1259084033-7283-1-git-send-email-saeed@marvell.com>
	<1259084033-7283-2-git-send-email-saeed@marvell.com>
	<FCBE654890C0334289D0AD3AF4EF009F89684D7F09@IL-MB01.marvell.com>
	<20091127200521.GC28193@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.0911271547110.2059@xanadu.home>
Message-ID: <c70ff3ad0911280004y5a78bed2ndc134c2a7e8b4382@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The board id that supported by this patch is 1788, the board name in
the machines registry updated to dove_db, but the Type Identifier
needs to be changed from MACH_TYPE_MACH_MARVELL_NEW1 to
MACH_TYPE_DOVE_DB.

saeed

On Fri, Nov 27, 2009 at 10:48 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Fri, 27 Nov 2009, Russell King - ARM Linux wrote:
>
>> On Wed, Nov 25, 2009 at 12:28:42AM +0200, Saeed Bishara wrote:
>> > ? ? For some reason, my previous email didn't reach the mailing list.
>> > ? ? Here is the patch as an attachment with some minor updates (replaced
>> > mach/gpio.h to linux/gpio.h)
>>
>> Also #include <asm/io.h> and (any) #include <mach/io.h> -> linux/io.h please.
>
> I amended the orion Git repository directly to fix those.
>
>
> Nicolas
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
