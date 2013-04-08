From: horms@verge.net.au (Simon Horman)
Date: Mon, 8 Apr 2013 11:06:38 +0900
Subject: [PATCH 00/02] ARM: shmobile: r8a7790 Lager arch timer fixes
In-Reply-To: <87r4ilolmh.wl%kuninori.morimoto.gx@renesas.com>
References: <20130408012318.13555.58237.sendpatchset@w520>
 <87r4ilolmh.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <20130408020637.GF13103@verge.net.au>
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

I guess that the solution is to ensure that patch 1 is applied
before patch 2. Am I missing something?

> Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
