From: peterz@infradead.org (Peter Zijlstra)
Date: Mon, 18 Oct 2010 17:48:00 +0200
Subject: [PATCH 0/3] Add OMAP hardware spinlock misc driver
In-Reply-To: <AANLkTi=w1Ge_JV41dvj1uaoFBo=UfX4ZtuHT=G6Kx1dF@mail.gmail.com>
References: <1287387875-14168-1-git-send-email-ohad@wizery.com>
	<1287406015.29097.1579.camel@twins>
	<20101018133502.GA12449@n2100.arm.linux.org.uk>
	<1287409417.29097.1598.camel@twins>
	<tnxeibnh67q.fsf@e102109-lin.cambridge.arm.com>
	<1287415929.29097.1616.camel@twins>
	<AANLkTi=w1Ge_JV41dvj1uaoFBo=UfX4ZtuHT=G6Kx1dF@mail.gmail.com>
Message-ID: <1287416880.1998.1927.camel@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-10-18 at 17:35 +0200, Ohad Ben-Cohen wrote:
> On Mon, Oct 18, 2010 at 5:32 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> > Sure, but you can 'easily' extend your coherency protocols with support
> 
> In our case, there are no coherency protocols supported between the
> A9, M3 and the DSP.

Sure, I got that, I was simply commenting on Catalin's statement that
cache coherency doesn't (need to) bring atomic modifications.
