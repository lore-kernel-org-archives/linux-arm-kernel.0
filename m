From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Thu, 14 May 2015 17:57:23 +0200
Subject: [PATCHv2 3/3] arch/arm64: Enable PREEMPT_RT_FULL
In-Reply-To: <1430167990-12333-4-git-send-email-anders.roxell@linaro.org>
References: <1430167990-12333-1-git-send-email-anders.roxell@linaro.org>
 <1430167990-12333-4-git-send-email-anders.roxell@linaro.org>
Message-ID: <20150514155723.GD13442@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Anders Roxell | 2015-04-27 22:53:10 [+0200]:

>arm64 is missing support for PREEMPT_RT. The main feature which is
>lacking is support for lazy preemption. The arch-specific entry code,

I'm taking this but I am renaming the subject. Lazy preempt is not
required by -RT but supporting it benefits it. That means you could run
arm64 without it.

Sebastian
