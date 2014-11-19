From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Nov 2014 23:42:23 +0100
Subject: [GIT PULL] arm: pxa: pxa for v3.19
In-Reply-To: <878uj67r2a.fsf@free.fr>
References: <87bnoevq1b.fsf@free.fr> <201411192333.32448.arnd@arndb.de>
 <878uj67r2a.fsf@free.fr>
Message-ID: <4686660.cI7P5U9Kgy@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 November 2014 23:39:57 Robert Jarzmik wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> 
> > Hi Robert,
> >
> > Sorry for the delay in replying. I noticed that you have based your
> > patches on top of v3.18-rc4. If you don't have a strong reason for
> > doing so, could you send everything based on an -rc1 in the future?
> 
> Ah no, no strong reason. I was waiting for v3.18-rc4 to have all the pxa fixes
> merged before doing my pull request. But there is no dependency between the
> fixes and this pull request, so the rebase will come for free.

FWIW, if a case like this comes up again, just base the changes for
the next kernel on top of the bug fixes you are sending for the same
platform.

> > If you don't mind, please rebase and send again.
> Of course, I will, this week-end.

We are running a bit short on time though, and I'd like to have it
merged earlier. If nobody else is using your branch, I can just do
the rebase myself, since there are only a few patches in it.

	Arnd
