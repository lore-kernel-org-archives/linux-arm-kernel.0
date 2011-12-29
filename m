From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 29 Dec 2011 15:23:17 +0800
Subject: [PATCH V5 4/7] cpufreq: add clk-reg cpufreq driver
In-Reply-To: <20111229062102.GA2414@b20223-02.ap.freescale.net>
References: <1324974262-30963-1-git-send-email-richard.zhao@linaro.org>
 <1324974262-30963-5-git-send-email-richard.zhao@linaro.org>
 <20111229062102.GA2414@b20223-02.ap.freescale.net>
Message-ID: <20111229072316.GB11474@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

On Thu, Dec 29, 2011 at 02:21:03PM +0800, Richard Zhao wrote:
> There's still a bug that, after rmmod module, cpu0 still has cpufreq
> sysfs entry.
> 
> cpufreq_unregister_driver can not clean up everything.
> 
Is this an known issue to cpufreq core?

-- 
Regards,
Shawn
