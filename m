From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 10 Apr 2014 08:42:53 +0100
Subject: [PATCH v5 0/8] mtd: spi-nor: add a new framework for SPI NOR
In-Reply-To: <20140409033603.GA32070@ld-irv-0074>
References: <1393238262-8622-1-git-send-email-b32955@freescale.com>
 <20140312081350.GC30808@shlinux2.ap.freescale.net>
 <20140313063940.GU31517@norris-Latitude-E6410>
 <20140409033603.GA32070@ld-irv-0074>
Message-ID: <20140410074253.GD4214@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> + Lee, Marek
> 
> Hi Huang,
> 
> On Wed, Mar 12, 2014 at 11:39:40PM -0700, Brian Norris wrote:
> > On Wed, Mar 12, 2014 at 04:13:51PM +0800, Huang Shijie wrote:
> > > On Mon, Feb 24, 2014 at 06:37:34PM +0800, Huang Shijie wrote:
> > >    Could you please review this patch set? I really hope it can be merged
> > >    as soon as possibel.  But now, the patch set has stalled for a long time.
> > 
> > I'm sorry for the delay. Others are in the same position of delay (e.g.,
> > Lee's SPI-NOR driver), because I simply have not had the time to really
> > devote this the attention it deserves, especially considering how it
> > rearchitects such an important, commonly-used driver.
> > 
> > Nonetheless, I will try to give your patches some more attention soon.
> > 
> > >    Since you have pushed the patches for m25p80.c, i have to rebase this
> > >    patch set again and again...
> > 
> > You mean locally? I promise you, I can handle rebasing on my reviewing
> > end for small one-line conflicts like new chip IDs, so don't rebase and
> > resend simply for that. Unless I find substantive things that you should
> > change, I'd only expect at most one more rebase to be necessary.
> 
> Unfortunately, I did not get the time to review and test this
> sufficiently for the 3.15 merge window, but to avoid further delay, I've
> queued it up in l2-mtd.git [1] under its own branch for now. I rebased
> it myself, to accommodate for changes to m25p80.c since your submission.
> Please take a look at the branch.
> 
> If all goes well, I should merge the spinor branch into master some time
> after the 3.15 merge window closes, so it will get linux-next testing.
> For any additional comments/corrections (I have a few), please just
> submit patches on top, rather than resending the whole series.
> 
> Marek, what was your opinion on this series? Last response I saw was
> "looking good"; is that an Ack? Or did you have any more gating
> requests?
> 
> Personally, I think it looks ready enough, and it's better to merge this
> than not. I was able to test with my platforms, with no regression.
> 
> Lee, I have a few patches that do some trivial unification of your ST
> SPI FSM driver and the SPI-NOR framework. I plan to send these out
> soon, and I will begin applying any ST-FSM patches to the same spinor
> branch along with Huang's code. I hope that you can spend some effort on
> improving integration within the next few months in preparation for
> 3.16, when I expect this to all go upstream.

I certainly plan to. Although, I'm up to my neck in the ST BCH NAND
driver at the moment. Trying to re-spin something that'll be
accepted i.e. more intensive use of the framework.

Quick question, is there a chat medium for MTD? Somewhere for
quick-fire questions i.e. an IRC channel or similar?

> [1] branch spinor, at http://git.infradead.org/l2-mtd.git

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
