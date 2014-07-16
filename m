From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 16 Jul 2014 09:27:20 -0400
Subject: [PATCHv2 00/17] cpuidle for Marvell Armada 370 and 38x
In-Reply-To: <20140716151955.377efc5e@free-electrons.com>
References: <1404913221-17343-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140713222223.GH13108@titan.lakedaemon.net>
 <20140716124522.GV13108@titan.lakedaemon.net>
 <20140716145905.33105756@free-electrons.com>
 <20140716131658.GB13108@titan.lakedaemon.net>
 <20140716151955.377efc5e@free-electrons.com>
Message-ID: <20140716132720.GC13108@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 16, 2014 at 03:19:55PM +0200, Thomas Petazzoni wrote:
> Dear Jason Cooper,
> 
> On Wed, 16 Jul 2014 09:16:58 -0400, Jason Cooper wrote:
> 
> > > As explained in the cover letter:
> > > 
> > >  * Series rebased on top of mvebu/fixes + mvebu/soc to take into
> > >    account the conflicts with the changes already merged on the PMSU
> > >    code.
> > 
> > Ok, I've tentatively applied this series to mvebu/soc-cpuidle with a dep
> > on mvebu/soc and mvebu/fixes.  It'll be in -next tonight.
> 
> Great, thanks a lot!

FYI - there's a rather intricate conflict in pmsu.c between cpuidle and
cpufreq.  I'm currently build-testing my merge.  Once it passes, I'll
push it up to for-next and I'd appreciate if you could give it a once
over.  It'll be the HEAD of for-next.

thx,

Jason.
