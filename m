From: horms@verge.net.au (Simon Horman)
Date: Mon, 30 Dec 2013 09:32:06 +0900
Subject: [GIT PULL 0/3] Renesas ARM based SoC IRQC Driver Updates for v3.14
In-Reply-To: <20131229212909.GF20958@quad.lixom.net>
References: <cover.1387855444.git.horms+renesas@verge.net.au>
 <20131229212909.GF20958@quad.lixom.net>
Message-ID: <20131230003203.GA31374@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 29, 2013 at 01:29:09PM -0800, Olof Johansson wrote:
> On Tue, Dec 24, 2013 at 03:05:46PM +0900, Simon Horman wrote:
> > Hi Kevin, Hi Olof, Hi Arnd,
> > 
> > please consider these Renesas ARM based SoC IRQC driver updates for v3.14.
> > 
> > The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:
> > 
> >   Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-irqc-for-v3.14
> > 
> > for you to fetch changes up to ce70af18801fd8dac6e9f85308294948916e84d6:
> > 
> >   irq-renesas-irqc: simplify irq_set_type() method (2013-12-23 09:27:17 +0900)
> 
> Pulled, thanks. These look mostly like trivial changes so I'm guessing Thomas
> will be fine with it going though our tree.
> 
> > ----------------------------------------------------------------
> > Renesas ARM based SoC IRQC Driver Updates for v3.14
> > 
> > * Simplify irq_set_type() method
> > * Enable mask on suspend
> > * Use lazy disable
> > 
> > ----------------------------------------------------------------
> > Magnus Damm (2):
> >       irqchip: renesas-irqc: Use lazy disable
> >       irqchip: renesas-irqc: Enable mask on suspend
> > 
> > Sergei Shtylyov (1):
> >       irq-renesas-irqc: simplify irq_set_type() method
> 
> Small nit: I've been giving some others reminders to keep consistent
> commit messages per platform/subsystem. Same here.

Thanks, I'll be more attentive to that.
