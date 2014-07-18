From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Sat, 19 Jul 2014 01:51:23 +0200
Subject: mvebu cpuidle and cpufreq branch handling for v3.17
In-Reply-To: <20140718230740.GR24496@titan.lakedaemon.net>
References: <20140718230740.GR24496@titan.lakedaemon.net>
Message-ID: <4295346.6091tevmKX@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, July 18, 2014 07:07:40 PM Jason Cooper wrote:
> Arnd, Olof, Kevin,
> 
> I have two branches with the remaining mvebu SoC changes for v3.17.
> They are mvebu/soc-cpuidle and mvebu/soc-cpufreq.  Each branch is
> slightly problematic because both contain changes to their respective
> code in drivers/.  To send the driver changes through the appropriate
> subsystems would be a garish nightmare of branch on branch on branch.
> Thankfully, the changes are isolated to drivers only mvebu uses, so
> keeping it all together should cause minimal, if any, conflicts.
> 
> I've requested Acks from the appropriate maintainers but as it's summer
> I'm not confident that we'll receive those Acks in time for the arm-soc
> cutoff (-rc6 -ish).
> 
> As I see it, I could send arm-soc two topic branch pull requests, which
> arm-soc would keep out separate on the remote chance of an objection.
> 
> Or, I could wait for the Acks (the code has already been in -next for
> several days), merge it into mvebu/soc, and send a, most likely, late
> pull request for it.
> 
> Which would you guys prefer?
> 
> The cpuidle branch and ML link:
> 
>   git://git.infradead.org/linux-mvebu.git mvebu/soc-cpuidle
> 
>   https://lkml.kernel.org/r/1404913221-17343-1-git-send-email-thomas.petazzoni at free-electrons.com
> 
> The cpufreq branch and ML link:
> 
>   git://git.infradead.org/linux-mvebu.git mvebu/soc-cpufreq
> 
>   https://lkml.kernel.org/r/1404920715-19834-1-git-send-email-thomas.petazzoni at free-electrons.com

I'm generally OK with the cpufreq/cpuidle changes here in drivers/, but as I
said in response to the cpuidle series, I'd like someone from the ARM side of
things to look at those changes too.

Rafael
