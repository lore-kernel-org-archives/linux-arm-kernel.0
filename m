From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 27 Jul 2013 12:20:05 +0200
Subject: DT bindings as ABI [was: Do we have people interested in device
 tree janitoring / cleanup?]
In-Reply-To: <20130727085259.GA6207@netboy>
References: <CAOesGMhJ+je8FZqeFxhAcYwU0CHYer+aGP6DA_8x3azrzfA2sw@mail.gmail.com>
 <20130726171524.GB28895@obsidianresearch.com> <20130727085259.GA6207@netboy>
Message-ID: <1776866.moAxavOOUJ@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 27 of July 2013 10:53:01 Richard Cochran wrote:
> On Fri, Jul 26, 2013 at 11:15:24AM -0600, Jason Gunthorpe wrote:
> > On Fri, Jul 26, 2013 at 06:54:33AM +0200, Richard Cochran wrote:
> > > I too work on commercial embedded systems, and DT has proven to be
> > > one gigantic *PITA*.
> > 
> > Why do you think our experiences are so different?
> 
> Here are a few recent examples:
> 
> * What happens when one wants to boot vanilla kernel on the beaglebone?
> 
>   http://www.spinics.net/lists/arm-kernel/msg198431.html

Not really understand point of quoting this thread here. Lack of support 
for Beaglebone at that time was not really related to device tree in any 
way, just not enough support for it was merged at that time (as I could 
read here: http://www.spinics.net/lists/arm-kernel/msg199863.html)

> * Wanting already merged code to work is too much to ask.
> 
>   http://www.spinics.net/lists/linux-omap/msg79731.html

This is about not enough synchronization between OMAP people and TI not 
pushing enough and quickly enough to mainline...

> * When people try in good faith to conduct methodical boot tests,
>   DT is working against them.
> 
>   http://www.spinics.net/lists/linux-omap/msg79960.html

I don't really see any relation with DT in this thread. Again this looks 
like support for this platform was not yet developed enough at that time 
in mainline kernel. Still, you managed to boot 3.7-rc2 
(http://thread.gmane.org/gmane.linux.ports.arm.omap/86719/focus=86952), 
didn't you?

I wouldn't really connect all the problems we are having currently with DT 
alone. For many ARM people this is still something new, something that 
they don't fully know how to work with yet. We don't have proper 
processes, examples, best practices, etc. This is what we are trying to 
fix and a key point of all those discussions like this one.

Best regards,
Tomasz
