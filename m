From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 9 Sep 2016 12:28:41 +0100
Subject: [PATCH] cpufreq: create link to policy only for registered CPUs
In-Reply-To: <20160909112204.GE18547@vireshk-i7>
References: <20160819110032.GM1041@n2100.armlinux.org.uk>
 <a0469c333e08b3953bfe9e8356c6919c26578349.1473414746.git.viresh.kumar@linaro.org>
 <20160909111620.GQ1041@n2100.armlinux.org.uk>
 <20160909112204.GE18547@vireshk-i7>
Message-ID: <20160909112841.GS1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 09, 2016 at 04:52:04PM +0530, Viresh Kumar wrote:
> Thanks for testing it.. You need another patch from Rafael, which
> should be in linux-next by now..
> 
> commit 3689ad7ed6a8 ("cpufreq: Drop unnecessary check from
> cpufreq_policy_alloc()")
> 
> Both patches combined will fix the problem you were getting.

Please send me this other patch.  Seems absurd to fix a reported problem
without copying appropriate patches to the reporter...

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
