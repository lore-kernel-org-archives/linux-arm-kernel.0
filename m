From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 20 Oct 2014 16:36:38 +0200
Subject: [GIT PULL] ARM: berlin: Driver changes for v3.18
In-Reply-To: <54451D7B.20309@gmail.com>
References: <1411425685-27276-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <201410011703.29695.arnd@arndb.de> <54451D7B.20309@gmail.com>
Message-ID: <2055721.MLiQlaVx8P@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 20 October 2014 16:34:35 Sebastian Hesselbarth wrote:
> On 01.10.2014 17:03, Arnd Bergmann wrote:
> > On Tuesday 23 September 2014, Sebastian Hesselbarth wrote:
> >> Berlin is a little quiet this time. Antoine is still doing a great job
> >> but ChipIdea USB didn't make it again this time. Let's hope it makes it
> >> next time.
> >>
> >> At least we can add the reset driver contained in this PR.
> >
> > I've pulled all three into the next/late branch, we'll decide next week
> > whether that makes it into 3.18, based on how things go with the stuff
> > in the normal branches.
> >
> > Please try to send stuff earlier next time so it can be part of the
> > regular submission.
> 
> Hmm, looks like I was really too late this time. Will try to send
> earlier PRs next cycle.
> 
> Anyway, how should I proceed with this now? Do you want me to reapply
> the patches on v3.18-rc1 and proceed with normal for-v3.19 cycle? Or
> should I merge arm-soc's next/late into berlin's for-v3.19 branches
> to apply new patches on top?
> 

The former.

We are not going to use the next/late branch this time, and all code
in it will be abandoned, so you should send it again.

Also, you should /never/ base anything on top of any of our next/*
branches. Always use the minimum set of branches as a base instead.

	Arnd
