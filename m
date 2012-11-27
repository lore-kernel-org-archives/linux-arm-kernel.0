From: anton.vorontsov@linaro.org (Anton Vorontsov)
Date: Tue, 27 Nov 2012 01:05:56 -0800
Subject: [PATCH 10/10] ARM: FIQ: Get rid of init_FIQ()
In-Reply-To: <20121123075138.GA2136@lizard>
References: <20121123003849.GA973@lizard.mcd25758.sjc.wayport.net>
 <1353652071.755665772@f76.mail.ru> <20121123065002.GB27827@lizard>
 <1353656161.911816605@f287.mail.ru> <20121123075138.GA2136@lizard>
Message-ID: <20121127090553.GA12289@lizard>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 22, 2012 at 11:51:38PM -0800, Anton Vorontsov wrote:
> On Fri, Nov 23, 2012 at 11:36:01AM +0400, Alexander Shiyan wrote:
> [...]
> > got_no_fiq_insn also not initialized.
> 
> It is static, so by definition it is initialized to 0.
> 
> > I think as a whole on this issue requires additional comments from Russell
> > as the author of implementation.
> > 
> > PS: In any case, I can reproduce it and check it out if you send me a patchset
> > to my email as an attachment.
> 
> Sent privately.

Andrew, Arnd, just FYI, it works for Alexander.

----- Forwarded message from Alexander Shiyan <shc_work@mail.ru> -----
Date: Tue, 27 Nov 2012 12:42:50 +0400
From: Alexander Shiyan <shc_work@mail.ru>
To: Anton Vorontsov <anton.vorontsov@linaro.org>
Subject: Re[2]: FIQ

> Hello Alexander,
> 
> On Tue, Nov 27, 2012 at 12:14:28PM +0400, Alexander Shiyan wrote:
> > Sorry, I lost the original message to the correct answer.
> > Today I had a test of removal init_FIQ.
> > The test took place on a custom board with a custom ARM CLPS711X OSS audio
> > driver, which uses the FIQ interrupts. Everything works fine.
> 
> Nice! Thanks a lot for testing!
> 
> Can you please reply to the original thread, with the
> 
> 	Tested-by: Alexander Shiyan <shc_work@mail.ru>
> ?
> 
> This will help pushing the series forward, plus will give you a credit for
> your efforts.

I am lost thread in my mailbox, you can just copy/paste my reply and ping for Arnd.
