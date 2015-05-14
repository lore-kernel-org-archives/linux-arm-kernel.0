From: will.deacon@arm.com (Will Deacon)
Date: Thu, 14 May 2015 16:42:15 +0100
Subject: [PATCHv2 1/3] arm64: Mark PMU interrupt IRQF_NO_THREAD
In-Reply-To: <20150514153937.GB13442@linutronix.de>
References: <1430167990-12333-1-git-send-email-anders.roxell@linaro.org>
 <1430167990-12333-2-git-send-email-anders.roxell@linaro.org>
 <20150514153937.GB13442@linutronix.de>
Message-ID: <20150514154215.GE18984@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 14, 2015 at 04:39:37PM +0100, Sebastian Andrzej Siewior wrote:
> * Anders Roxell | 2015-04-27 22:53:08 [+0200]:
> 
> >Mark the PMU interrupts as non-threadable, as is the case with
> >arch/arm: d9c3365 ARM: 7813/1: Mark pmu interupt IRQF_NO_THREAD
> >
> >Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> >Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> Could this please go via the arm64 tree?

I already acked it:

  https://lkml.org/lkml/2015/4/23/161

so it will be picked up for 4.2.

Will
