From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Wed, 11 Jan 2012 09:36:51 +0100 (CET)
Subject: linux-next: manual merge of the v4l-dvb tree with the arm-soc tree
In-Reply-To: <CAOesGMh0W1hvpySB8jtVBojZtoniHXur98Bzq1Feh3vAD4CkOg@mail.gmail.com>
References: <20120111133146.990e2b7115c9fa80e8fc3234@canb.auug.org.au>
 <CAOesGMh0W1hvpySB8jtVBojZtoniHXur98Bzq1Feh3vAD4CkOg@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.1201110933480.1191@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 10 Jan 2012, Olof Johansson wrote:

> On Tue, Jan 10, 2012 at 6:31 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > Hi Mauro,
> >
> > Today's linux-next merge of the v4l-dvb tree got conflicts in a large
> > number of files between commits from the arm-soc tree and commits from the
> > v4l-dvb tree. ?You have rebased the v4l-dvb tree onto v3.2 while the
> > arm-soc tree had merged a previous version. you have then added a lot
> > more commits on top of the result - which produces all the conflicts. ?:-(
> >
> > This is exactly the sort of pain I alluded to when I first noted that the
> > v4l-dvb tree had been merged into the arm-soc tree ...
> 
> We do this every now and then though, it's not an issue as long as
> nothing stupid is done with the dependent branch at the other end.
> I.e. if it's actually a stable branch (which we got promised that it
> was).
> 
> So, why was the whole v4l tree rebased? Guennadi, you said it was
> going to be a stable branch? What happened?

Sorry, I don't think I _promised_ anything, I even don't think I said 
anything at all about the stability of that branch. On the contrary - I 
suggested you to only take _one_ patch, about which we knew, that some ARM 
patches depended upon, for which I've got Mauro's ack. This has been done 
with the sole purpose for you to avoid any dependencies. Instead you 
decided to pull the whole branch.

> > Not happy.
> 
> No kidding.  Mauro, can you undo your rebase or should I remove the
> dependent branch (and the at91 branch that needs it) from arm-soc
> instead?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
