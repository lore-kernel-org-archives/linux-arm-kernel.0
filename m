From: horms@verge.net.au (Simon Horman)
Date: Tue, 9 Apr 2013 21:42:46 +0900
Subject: [PATCH 00/02] ARM: shmobile: r8a7790 Lager arch timer fixes
In-Reply-To: <87r4ilolmh.wl%kuninori.morimoto.gx@renesas.com>
References: <20130408012318.13555.58237.sendpatchset@w520>
 <87r4ilolmh.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <20130409124245.GE15412@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 07, 2013 at 06:29:46PM -0700, Kuninori Morimoto wrote:
> 
> Hi
> 
> > ARM: shmobile: r8a7790 Lager arch timer fixes
> > 
> > [PATCH 01/02] ARM: shmobile: force enable of r8a7790 arch timer 
> > [PATCH 02/02] ARM: shmobile: use r8a7790 timer setup code on Lager
> > 
> > This mini-series contains fixes to start the arch timer on
> > r8a7790 and the Lager board regardless of boot loader setting.
> > 
> > Signed-off-by: Magnus Damm <damm@opensource.se>
> > ---
> 
> I guess shmobile_timer_init() will be conflict (or compile error)
> on next (?) merge window thought...
> but, for current code/branch

[ discussed in another sub-thread ]

> Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks.

01/02 queued up in the soc-r8a7790 branch
02/02 queue up in the boards-lager branch,
      which is a merge of renesas-boards3-for-v3.10 and soc-r8a7790
