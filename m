From: ben-i2c@fluff.org (Ben Dooks)
Date: Tue, 4 Oct 2011 21:59:41 +0100
Subject: [PATCH 32/55] i2c: irq: Remove IRQF_DISABLED
In-Reply-To: <1316681962-8217-33-git-send-email-yong.zhang0@gmail.com>
References: <1316681962-8217-1-git-send-email-yong.zhang0@gmail.com>
	<1316681962-8217-33-git-send-email-yong.zhang0@gmail.com>
Message-ID: <20111004205941.GJ19115@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 22, 2011 at 04:58:59PM +0800, Yong Zhang wrote:
> Since commit [e58aa3d2: genirq: Run irq handlers with interrupts disabled],
> We run all interrupt handlers with interrupts disabled
> and we even check and yell when an interrupt handler
> returns with interrupts enabled (see commit [b738a50a:
> genirq: Warn when handler enables interrupts]).
> 
> So now this flag is a NOOP and can be removed.

ok, applied thanks.

-- 
Ben Dooks, ben at fluff.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
