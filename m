From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 14 Nov 2013 12:08:46 +0000
Subject: a bug on NO_HZ_FULL_ALL
In-Reply-To: <20131114115313.GC16501@localhost.localdomain>
References: <CANHzE=2EOJmjFqLUDSfxTvgQhrUogOxH8Qux9hBFTGf8HiWWEw@mail.gmail.com>
 <52843855.5060509@linaro.org> <52847FBE.9070501@linaro.org>
 <CAKfTPtD7fo08mjQoLXMMDpyxQuyoCZLS33qBnnUcQEmzYai2VQ@mail.gmail.com>
 <52848547.9080604@linaro.org>
 <CANHzE=0yshUSnxRRhQ_hBjo8ze4pSzuWQq+SAWdosq+wdP8hFg@mail.gmail.com>
 <20131114115313.GC16501@localhost.localdomain>
Message-ID: <20131114120845.GA16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 14, 2013 at 12:53:15PM +0100, Frederic Weisbecker wrote:
> BTW, support for ARM's full dynticks is uncomplete without
> "[PATCH] ARM: Support arch_irq_work_raise() via self IPIs"
> 
> ...which I'm not sure is applied upstream, or even any ARM tree yet.

It's in mainline as of last night, along with a fix to the above patch.
