From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 9 Sep 2016 17:04:59 +0530
Subject: [PATCH] cpufreq: create link to policy only for registered CPUs
In-Reply-To: <20160909112841.GS1041@n2100.armlinux.org.uk>
References: <20160819110032.GM1041@n2100.armlinux.org.uk>
 <a0469c333e08b3953bfe9e8356c6919c26578349.1473414746.git.viresh.kumar@linaro.org>
 <20160909111620.GQ1041@n2100.armlinux.org.uk>
 <20160909112204.GE18547@vireshk-i7>
 <20160909112841.GS1041@n2100.armlinux.org.uk>
Message-ID: <20160909113459.GG18547@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09-09-16, 12:28, Russell King - ARM Linux wrote:
> On Fri, Sep 09, 2016 at 04:52:04PM +0530, Viresh Kumar wrote:
> > Thanks for testing it.. You need another patch from Rafael, which
> > should be in linux-next by now..
> > 
> > commit 3689ad7ed6a8 ("cpufreq: Drop unnecessary check from
> > cpufreq_policy_alloc()")
> > 
> > Both patches combined will fix the problem you were getting.
> 
> Please send me this other patch.  Seems absurd to fix a reported problem
> without copying appropriate patches to the reporter...

It got merged separately, and yes you should have been cc'd for that
as well.

Please find it attached now..

-- 
viresh
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-cpufreq-Drop-unnecessary-check-from-cpufreq_policy_a.patch
Type: text/x-diff
Size: 1223 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160909/6d7f844a/attachment.bin>
