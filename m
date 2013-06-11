From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 11 Jun 2013 12:12:38 -0400 (EDT)
Subject: [RFC PATCH v2 0/2] ARM: MPIDR linearization
In-Reply-To: <51B748BB.7070602@wwwdotorg.org>
References: <1370532125-14322-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20130611095848.GD8164@e102568-lin.cambridge.arm.com>
 <51B748BB.7070602@wwwdotorg.org>
Message-ID: <alpine.LFD.2.03.1306111209400.18597@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 11 Jun 2013, Stephen Warren wrote:

> On 06/11/2013 03:58 AM, Lorenzo Pieralisi wrote:
> > Hi Russell, all,
> > 
> > even though I think this set is ready to get merged, it would be great
> > if we can test it on as many platforms as possible since it touches core
> > suspend/resume operations on ARM platforms relying on CONFIG_ARM_CPU_SUSPEND,
> > and there are many.
> 
> FWIW, I booted a Tegra system with these patches applied and didn't see
> any issue in very brief testing. I'm not sure what targeted testing
> would be useful?

Deep idle mode where the CPU is turned off and has to re-enter the 
kernel via cpu_resume.


Nicolas
