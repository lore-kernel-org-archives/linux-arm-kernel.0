From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 24 Sep 2014 10:44:39 +0300
Subject: [PATCH 0/3] Introduce of_match_machine() helper
In-Reply-To: <20140919131245.GQ26779@tbergstrom-lnx.Nvidia.com>
References: <1407452515-2390-1-git-send-email-ttynkkynen@nvidia.com>
 <53FB7642.1000808@wwwdotorg.org>
 <20140919131245.GQ26779@tbergstrom-lnx.Nvidia.com>
Message-ID: <20140924074439.GA25537@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 19, 2014 at 04:12:45PM +0300, Peter De Schrijver wrote:
> On Mon, Aug 25, 2014 at 07:45:38PM +0200, Stephen Warren wrote:
> > On 08/07/2014 05:01 PM, Tuomas Tynkkynen wrote:
> > > Some mach-specific drivers that don't require their own node in the device tree
> > > (for example drivers/soc/*, cpufreq, cpuidle etc.) want to match on the device
> > > tree root compatible property instead. Instead of open-coding (and forgetting
> > > to call of_node_put on the root node) everywhere, add a helper to the OF core.
> > 
> > Tuomas, I assume there will be a new version of this series to address 
> > the review comments? For now, I'm not intending on applying this.
> 
> Given that Tuomas's internship ended, I'm willing to push this patch set
> forward, if there is interest. So are people still interested in this idea
> or should we drop it?

Seems there's no interest. I won't bother with this then.

Cheers,

Peter.
