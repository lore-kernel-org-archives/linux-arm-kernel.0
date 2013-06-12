From: olof@lixom.net (Olof Johansson)
Date: Wed, 12 Jun 2013 14:29:01 -0700
Subject: [GIT PULL] MCPM backend for VExpress TC2
In-Reply-To: <alpine.LFD.2.03.1306121612150.18597@syhkavp.arg>
References: <alpine.LFD.2.03.1306121612150.18597@syhkavp.arg>
Message-ID: <20130612212901.GA7012@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


On Wed, Jun 12, 2013 at 04:52:38PM -0400, Nicolas Pitre wrote:
> ARnd, Olof, please pull the following:
> 
>         git://git.linaro.org/people/nico/linux TC2
> 
> This is the MCPM backend submission for VExpress with a TC2 core tile.
> This enables SMP secondary boot, CPU hotplug, and paves the way for 
> cpuidle and cpufreq on this platform.
> 
> A big prerequisite for this support is the serial power controller 
> driver posted by Lorenzo and extensively reviewed on the list.  Because 
> of the strict dependency, we asked Samuel Ortiz twice for his ACK to 
> merge it via ARM-SOC:
> 
> 	http://article.gmane.org/gmane.linux.kernel/1506121
> 
> But no reply came back so far.  If Samuel had any issues with this 
> driver I'm trusting he would have had ample time to express them at this 
> point.  I'm therefore including it by default.

I just pinged Sam on IRC and he said he'll look at them shortly, so we'll wait
for his review. They were, after all, only posted 2.5 weeks ago for the first
time.


Thanks,

-Olof
