From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 1 Apr 2011 01:53:05 +0100
Subject: [GIT PULL] omap changes for v2.6.39 merge window
In-Reply-To: <alpine.LFD.2.00.1103311649450.28032@xanadu.home>
References: <alpine.DEB.2.00.1103302130500.29543@asgard.lang.hm>
	<alpine.LFD.2.00.1103310145390.28032@xanadu.home>
	<20110331080634.GA18022@elte.hu>
	<20110331083044.GB14323@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1103310855450.29543@asgard.lang.hm>
	<20110331164539.GB19452@n2100.arm.linux.org.uk>
	<AANLkTi=tyifvJU-hhdd7gT74GMctrCbQBdUAoEaRXOCy@mail.gmail.com>
	<alpine.LFD.2.00.1103311429590.28032@xanadu.home>
	<AANLkTi=kbozPcWEk9wVZb7emSWx48BJQS=7Uzaya9Lor@mail.gmail.com>
	<alpine.LFD.2.00.1103311649450.28032@xanadu.home>
Message-ID: <20110401005304.GA17857@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 31, 2011 at 06:49:11PM -0400, Nicolas Pitre wrote:
> On Thu, 31 Mar 2011, Linus Torvalds wrote:

> > The only way to get quality code is to try to improve the quality from
> > the "leaf nodes", because otherwise you'll always end up playing
> > catch-up. You'll get new bad code faster than you can clean it up.
> 
> Leaf nodes on ARM are people coming from corporate background with the 
> old school software development methodologies.  They do it as a _job_ 
> first and foremost.  They only work on Linux because that's what their 
> boss assigned them to. Don't get me wrong: that doesn't mean they are 
> bad people.  Simply that they are not into it for the public recognition 
> (or flaming) from their peers.  Once their code works they lose interest 
> and move on.  That mindset is extremely hard to change and take time, on 
> a scale of years.  Much more time than required to produce the code 
> needed to support that new SOC out of the pipeline.  There are notable 
> exceptions obviously.  But this is still a scalability problem in 
> itself.  So we need men-in-the-middle attacks.

It's also often the case that the leaf maintainers are themselves
overloaded with work, especially those who don't have much code in tree
already or who have advanced power management features in their devices
that they're trying to support (which tend to be the area that requires
most work as they're system wide in impact).  

> > This really isn't the argument. The argument should be that if they
> > want their code up-stream, they need to do a good job. If they don't,
> > why should you take it at all?

> Embedded vendors did keep their code out of the kernel before.  We've 
> been hammering them about upstreaming their code for years.  Now they 
> are striking back with too much code for our review capacity.  So 
> problematic code gets merged without anyone noticing because it compiles 
> and does work, until someone comes along with a wide scale API cleanup 
> and stumble on it.

Plus the fact that even if the code isn't of the quality we'd ideally
like you do tend to get *some* quality improvement from pushing things
into mainline simply by virtue of 1000 foot review and it's much more
likely that random people will come along and contribute improvements to
mainline than to vendor BSPs.  Speaking as someone who works over many
different embedded CPUs (not just ARM) I'm generally thankful when I'm
working with mainline code, even if it's not the mainline code I might
dream of.  There are some great out of tree BSPs but there's also
others.
