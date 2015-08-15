From: edubezval@gmail.com (Eduardo Valentin)
Date: Fri, 14 Aug 2015 18:10:16 -0700
Subject: [PATCH V2] thermal: cpu_cooling: fix lockdep problems in
 cpu_cooling
In-Reply-To: <20150814055556.GZ20238@linux>
References: <16e7d7d811fa2b0f8dcf6cade345a5f2f3e3c36a.1439372926.git.viresh.kumar@linaro.org>
 <20150814055556.GZ20238@linux>
Message-ID: <20150815011015.GA4125@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 14, 2015 at 11:25:56AM +0530, Viresh Kumar wrote:
> On 12-08-15, 15:22, Viresh Kumar wrote:
> > From: Russell King <rmk+kernel@arm.linux.org.uk>
> > Fixes: 2dcd851fe4b4 ("thermal: cpu_cooling: Update always cpufreq policy with
> > Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> > 
> > Hi Eduardo/Zhang,
> > 
> > This is 4.2-rc material, please apply soon.
> 
> Hey,
> 
> Please apply this one and drop
> 
> 8ad61f934e9e ("thermal: cpu_cooling: fix lockdep problems in
> cpu_cooling")

OK, I am having a looking at this.

> 
> -- 
> viresh
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150814/7b2c8ec3/attachment.sig>
