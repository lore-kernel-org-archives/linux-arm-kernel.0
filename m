From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 11 Jun 2013 17:22:25 +0100
Subject: [RFC PATCH v2 0/2] ARM: MPIDR linearization
In-Reply-To: <51B748BB.7070602@wwwdotorg.org>
References: <1370532125-14322-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20130611095848.GD8164@e102568-lin.cambridge.arm.com>
 <51B748BB.7070602@wwwdotorg.org>
Message-ID: <20130611162224.GA13741@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Tue, Jun 11, 2013 at 04:56:43PM +0100, Stephen Warren wrote:
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

That's great thanks. CPUidle deep C-states (when CPUs resume from reset
through cpu_resume) are the main triggers of this code, so you should be
running with them enabled to test it.

Thank you very much !!
Lorenzo
