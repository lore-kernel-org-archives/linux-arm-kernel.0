From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 9 Sep 2016 15:27:42 +0530
Subject: Kernel warning in cpufreq_add_dev()
In-Reply-To: <1496109.Jd9MGDryNS@vostro.rjw.lan>
References: <20160819110032.GM1041@n2100.armlinux.org.uk>
 <2310664.2BksGViL4r@vostro.rjw.lan> <20160824131316.GI25143@ubuntu>
 <1496109.Jd9MGDryNS@vostro.rjw.lan>
Message-ID: <20160909095742.GA18547@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31-08-16, 03:26, Rafael J. Wysocki wrote:
> I was thinking about something similar, but won't the WARN_ON()s in
> cpufreq_add/remove_dev_symlink() still trigger, say if there's more
> than one CPU in a policy and both happen to be online initially?

Right. I missed that. I have sent a patch just now in reply to the first email
from Russell. That should fix it all..

@Russell: Can you please test/verify the patch I have sent now?

-- 
viresh
