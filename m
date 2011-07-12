From: arnd.bergmann@linaro.org (Arnd Bergmann)
Date: Tue, 12 Jul 2011 17:23:27 +0200
Subject: [GIT PULL] pxa: features for next
In-Reply-To: <CAMPhdO9ibczzuyoyyQBi=MntkWaAfAGRtfvORDYw0En7MWLwhQ@mail.gmail.com>
References: <CAMPhdO8uQR4km9szkuGDjuym-hViE9+zxtie6D2WGJmf1_9rUg@mail.gmail.com>
	<201107112319.38768.arnd.bergmann@linaro.org>
	<CAMPhdO9ibczzuyoyyQBi=MntkWaAfAGRtfvORDYw0En7MWLwhQ@mail.gmail.com>
Message-ID: <201107121723.27151.arnd.bergmann@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 July 2011, Eric Miao wrote:
> And Russell kindly provided a better fix, and I've merged and rebased
> the whole series. Please consider re-pull (just pushed, sync to git.k.o
> is in still in progress I guess).
> 
> I posted the patch as below, with the name changed to handle_IRQ for
> non-exception stack dump use (as the original handle_irq_event conflicts
> with the one in kernel/irq/).

Ok, pulled. Thanks,

	Arnd
