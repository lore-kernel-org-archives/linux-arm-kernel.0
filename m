From: rabin@rab.in (Rabin Vincent)
Date: Sat, 21 Jan 2012 22:09:58 +0530
Subject: [PATCH v4] ARM: Add generic instruction opcode manipulation
 helpers
In-Reply-To: <20111222112751.GB2573@localhost>
References: <1324305365-22514-1-git-send-email-dave.martin@linaro.org>
 <alpine.LFD.2.02.1112191201360.2907@xanadu.home>
 <20111222112751.GB2573@localhost>
Message-ID: <CAH+eYFDSimuWrc=pfwSxgHSneJ2m+pdzLxDjZhinvwHYb3MhGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 22, 2011 at 16:57, Dave Martin <dave.martin@linaro.org> wrote:
> On Mon, Dec 19, 2011 at 12:03:32PM -0500, Nicolas Pitre wrote:
>> On Mon, 19 Dec 2011, Dave Martin wrote:
>> > v4: Rebase on top of Leif's patch which created <asm/opcodes.h>
>> > ? ? ARM: 7206/1: Add generic ARM instruction set condition code checks.
>>
>> In that case you might be able to put your patch in the patch system,
>> and then go back to add a note for Russell mentioning 7206/1 is a
>> prerequisite.
>
> OK, I'll try and do that.

I notice it's there now as 7278/1, but there appears to be a problem
with it.  The patch system page shows the patch containing both the
rebased and the earlier versions:

http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7278/1
