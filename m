From: tony@atomide.com (Tony Lindgren)
Date: Tue, 3 May 2011 00:42:55 -0700
Subject: [PATCH v2 2/2] arm: omap: gpmc-smsc911x: minor style fixes
In-Reply-To: <BANLkTim-cu5_-pt5VxBunjqLWiHyHuo2xg@mail.gmail.com>
References: <4DB6E937.7090904@compulab.co.il>
	<1303835156-14516-1-git-send-email-grinberg@compulab.co.il>
	<BANLkTim-cu5_-pt5VxBunjqLWiHyHuo2xg@mail.gmail.com>
Message-ID: <20110503074254.GK2092@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Menon, Nishanth <nm@ti.com> [110426 14:05]:
> On Tue, Apr 26, 2011 at 11:25, Igor Grinberg <grinberg@compulab.co.il> wrote:
> >
> > replace "printk(KERN_ERR" by "pr_err("
> > and fix needlessly multi-lined #ifdef
> >
> > Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> 
> Acked-by: Nishanth Menon <nm@ti.com>

Thanks, will queue this too. One line negative diffstat, whee!

Tony
