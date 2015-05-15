From: anders.roxell@linaro.org (Anders Roxell)
Date: Fri, 15 May 2015 14:08:10 +0200
Subject: [PATCHv2 3/3] arch/arm64: Enable PREEMPT_RT_FULL
In-Reply-To: <20150514155723.GD13442@linutronix.de>
References: <1430167990-12333-1-git-send-email-anders.roxell@linaro.org>
 <1430167990-12333-4-git-send-email-anders.roxell@linaro.org>
 <20150514155723.GD13442@linutronix.de>
Message-ID: <20150515120810.GA10988@8074w.roxell.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-05-14 17:57, Sebastian Andrzej Siewior wrote:
> * Anders Roxell | 2015-04-27 22:53:10 [+0200]:
> 
> >arm64 is missing support for PREEMPT_RT. The main feature which is
> >lacking is support for lazy preemption. The arch-specific entry code,
> 
> I'm taking this but I am renaming the subject. Lazy preempt is not
> required by -RT but supporting it benefits it. That means you could run
> arm64 without it.

Thanks for picking up the patch and fixing the subject,
though I was surprised to see the ownership changed.

Cheers,
Anders
