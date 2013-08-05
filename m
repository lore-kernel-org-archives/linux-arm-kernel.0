From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 5 Aug 2013 11:36:12 -0500
Subject: [PATCH 07/10] ARM: clps711x: Add CLPS711X irqchip driver
In-Reply-To: <201308032145.41860.arnd@arndb.de>
References: <1374172501-26796-1-git-send-email-shc_work@mail.ru>
 <20130802105754.GF2884@e106331-lin.cambridge.arm.com>
 <20130802195552.2f95c855fc20d6b3a205e40f@mail.ru>
 <201308032145.41860.arnd@arndb.de>
Message-ID: <ADE657CA350FB648AAC2C43247A983F0021DAC6D5D3A@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, August 03, 2013 12:46 PM, Arnd Bergmann wrote:
> On Friday 02 August 2013, Alexander Shiyan wrote:
>> On Fri, 2 Aug 2013 11:57:54 +0100
>> Mark Rutland <mark.rutland@arm.com> wrote:
>>> On Thu, Jul 18, 2013 at 07:34:58PM +0100, Alexander Shiyan wrote:

<snip>

>>> 
>>> Isn't that SoC specific?
>> 
>> I absolutely do not understand the last two comments.
>> You are not difficult to describe them in other words?
>
> The point that Mark was making is that the both the binding and the driver
> should be written to only specify what the interrupt controller itself
> looks like, not how any of the lines are connected or configured.
>
> For instance, if the same interrupt controller is used in another SoC
>  (ep93xx?) but that soc has an i2c controller connected to IRQ 4 rather than
> the sound, the driver should still be usable unmodified.

FWIW, the cpls711x and ep93xx are completely different.

I'm not sure, but I think the cpls711x is a Cirrus EP73xx series processor 
(CPU_ARM720T). The EP93xx series processor is a CPU_ARM920T.

Regards,
Hartley
