From: robherring2@gmail.com (Rob Herring)
Date: Tue, 22 Apr 2014 10:30:36 -0500
Subject: [PATCH v2 0/7] of: setup dma parameters using dma-ranges and
 dma-coherent
In-Reply-To: <20140422152529.GE10224@arm.com>
References: <1397917972-6293-1-git-send-email-santosh.shilimkar@ti.com>
 <20140419182528.414b9b2e@skate> <201404221702.19842.arnd@arndb.de>
 <20140422152529.GE10224@arm.com>
Message-ID: <CAL_JsqJktpEBE1rAXDKX8uNSrWzgP1Scucvzrtw0auQSC=SO_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 22, 2014 at 10:25 AM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Tue, Apr 22, 2014 at 04:02:19PM +0100, Arnd Bergmann wrote:
>> On Saturday 19 April 2014, Thomas Petazzoni wrote:

[...]

>> I would hope we can find a way to avoid the platform notifiers for
>> mvebu as well and come up with a generic way to express this
>> 'semi-coherent' mode. I believe x-gene has a similar issue, and
>> I wouldn't be surprised if there are others like this.
>
> The solution is for the snooping unit to detect the DSB instruction
> (which is propagated outside the CPU) and wait for the completion of the
> coherency work (but we need more information from the hardware guys).

If the solution was fixing broken h/w, we'd all be retired (or h/w
designers). :)

Rob
