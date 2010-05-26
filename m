From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 26 May 2010 23:25:30 +0100
Subject: [PATCH] sa1111: Prevent deadlock in resume path
In-Reply-To: <201005262352.34052.marek.vasut@gmail.com>
References: <1274901104-22133-1-git-send-email-marek.vasut@gmail.com>
	<201005262333.47046.marek.vasut@gmail.com>
	<20100526214236.GC16418@n2100.arm.linux.org.uk>
	<201005262352.34052.marek.vasut@gmail.com>
Message-ID: <20100526222530.GD16418@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 26, 2010 at 11:52:33PM +0200, Marek Vasut wrote:
> You don't want the patch? Fine by me ... Anyway, please, open your eyes, look 
> around, noone in the whole community does such complications. Why do you do 
> that? What does it help? Why can't you just pick patches as everyone else does 
> -- from email. That's why git supports it.

What you're saying is that *everyone* has to conform to your way of
working.  Sorry, the human race isn't like that.  Humans are individuals,
and each one has their own quirks.

Mine is that I'm dreadful at dealing with patches in email.  Unless I
deal with a message at the point I've read it, it basically doesn't
exist.  So I created the patch system 10 years ago to solve that problem
- to keep patches around and visible, *and* to make them easier for me
to merge.

So your choice is:

1. send patches by email, but have to repeatedly send them to get them
   applied.

2. send the patch to the patch system so that it's easily visible and
   doesn't get buried beneath a mountain of email.

Lastly, I don't do kernel work 7 days a week.  I do have time off when I
don't look at the kernel tree, but I still read email.  Maybe you'd
prefer me to ignore all email on those days I'm not working instead?

The patch system is there to _solve_ a problem.  If you don't want to
use it, the fine, don't expect that problem to be solved for your
patches.

And now, at this point I really don't have any more time for you and
these stupid, idiotic and childish politics.
