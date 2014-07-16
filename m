From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 16 Jul 2014 15:28:38 +0200
Subject: [PATCHv2 00/17] cpuidle for Marvell Armada 370 and 38x
In-Reply-To: <20140716132720.GC13108@titan.lakedaemon.net>
References: <1404913221-17343-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140713222223.GH13108@titan.lakedaemon.net>
 <20140716124522.GV13108@titan.lakedaemon.net>
 <20140716145905.33105756@free-electrons.com>
 <20140716131658.GB13108@titan.lakedaemon.net>
 <20140716151955.377efc5e@free-electrons.com>
 <20140716132720.GC13108@titan.lakedaemon.net>
Message-ID: <20140716152838.3a469cdb@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Cooper,

On Wed, 16 Jul 2014 09:27:20 -0400, Jason Cooper wrote:

> > > Ok, I've tentatively applied this series to mvebu/soc-cpuidle with a dep
> > > on mvebu/soc and mvebu/fixes.  It'll be in -next tonight.
> > 
> > Great, thanks a lot!
> 
> FYI - there's a rather intricate conflict in pmsu.c between cpuidle and
> cpufreq.

Yeah, doesn't surprise me. All those power management features are very
inter-related.

>  I'm currently build-testing my merge.  Once it passes, I'll
> push it up to for-next and I'd appreciate if you could give it a once
> over.  It'll be the HEAD of for-next.

Sure, I'll have a look, I'll even try to run test for-next on the
platforms.

Thanks a lot!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
