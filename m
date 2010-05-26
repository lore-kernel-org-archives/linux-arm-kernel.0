From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 27 May 2010 00:35:54 +0200
Subject: [PATCH] sa1111: Prevent deadlock in resume path
In-Reply-To: <20100526222530.GD16418@n2100.arm.linux.org.uk>
References: <1274901104-22133-1-git-send-email-marek.vasut@gmail.com>
	<201005262352.34052.marek.vasut@gmail.com>
	<20100526222530.GD16418@n2100.arm.linux.org.uk>
Message-ID: <201005270035.54509.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?t 27. kv?tna 2010 00:25:30 Russell King - ARM Linux napsal(a):
> On Wed, May 26, 2010 at 11:52:33PM +0200, Marek Vasut wrote:
> > You don't want the patch? Fine by me ... Anyway, please, open your eyes,
> > look around, noone in the whole community does such complications. Why
> > do you do that? What does it help? Why can't you just pick patches as
> > everyone else does -- from email. That's why git supports it.
> 
> What you're saying is that *everyone* has to conform to your way of
> working. 

Come on, you know it's not what I said.

> Sorry, the human race isn't like that.  Humans are individuals,
> and each one has their own quirks.

Fine by me, there aren't many people I have problems with.
> 
> Mine is that I'm dreadful at dealing with patches in email.  Unless I
> deal with a message at the point I've read it, it basically doesn't
> exist. 

Why don't you set up a mailbox for that ? You read the emails anyway and you can 
drop the patches you Ack into that mailbox ... then run git am on that once in a 
while.
> So I created the patch system 10 years ago to solve that problem
> - to keep patches around and visible, *and* to make them easier for me
> to merge.

Things changed ever since then ...
> 
> So your choice is:
> 
> 1. send patches by email, but have to repeatedly send them to get them
>    applied.
> 
> 2. send the patch to the patch system so that it's easily visible and
>    doesn't get buried beneath a mountain of email.
> 
> Lastly, I don't do kernel work 7 days a week. 

Neither do I, nor am I paid for it. I do it in my free time.

> I do have time off when I
> don't look at the kernel tree, but I still read email. Maybe you'd
> prefer me to ignore all email on those days I'm not working instead?

See above please.
> 
> The patch system is there to _solve_ a problem. 

And it's there to create another one.

> If you don't want to use it, the fine, don't expect that problem to be solved 
> for your patches.

The problem should be solved already. This discussion was here already, it 
repeats and people complain.
> 
> And now, at this point I really don't have any more time for you and
> these stupid, idiotic and childish politics.

I'm just trying to solve a real problem here.
