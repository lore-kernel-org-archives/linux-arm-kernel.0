From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 6 May 2010 10:15:25 +0100
Subject: SAMSUNG kernel tree merge plans
In-Reply-To: <201005061021.06125.anarsoul@gmail.com>
References: <20100506054651.GL26401@trinity.fluff.org>
	<201005061021.06125.anarsoul@gmail.com>
Message-ID: <20100506091524.GD6684@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 06, 2010 at 10:21:02AM +0300, Vasily Khoruzhick wrote:
> ?? ?????????????????? ???? 6 ?????? 2010 08:46:51 ?????????? Ben Dooks ??????????????:
> > I'm busy sorting out the trees for the next mege window, and should
> > have a new next-samsung out in the next two or three days.
> > 
> > As such, if there is anything that needs to go via Russell's tree, then
> > it needs to be merged as soon as possible. I would like to send a pull
> > before Wednesday.
> > 
> > Anything else, if it is not merged into one of my trees by the end of
> > next week (May 14th) then there is no guarantees that it will be merged.
> > 
> > If everyone interested in this could check my trees after the weekend and
> > make any reminders of other stuff to fix at that point as there is still
> > items being processed.
> > 
> > http://git.fluff.org/gitweb?p=bjdooks/linux.git;a=summary
> 
> Is there any chance that my rx1950-support patch series will be merged? I've 
> almost finished moving to gpiolib and can send series after this weekend. What 
> branch of your tree should I use as base?

At the worst, just use linus' latest and any merge differences can be
dealt with when merging. Given that gpiolib mostly works already, it
shouldn't be necessary to do any machine changes when merging.

I'll announce a new samsung-next as soon as possible.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
