From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 03 Mar 2014 11:26:48 +0100
Subject: [GIT PULL] Reset controller fixes and updates
In-Reply-To: <1392731862.3606.42.camel@pizza.hi.pengutronix.de>
References: <1392731862.3606.42.camel@pizza.hi.pengutronix.de>
Message-ID: <1393842408.3323.28.camel@paszta.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd,

could you please have a look at those changes?

Am Dienstag, den 18.02.2014, 14:57 +0100 schrieb Philipp Zabel:
> Hi Olof, Arnd,
> 
> since I didn't get any more feedback on the GPIO reset patch, and I
> don't want to risk postponing the following changes (again), I've left
> it out of this pull request. Please consider merging the following fixes
> and updates. The changes since commit
> 38dbfb59d1175ef458d006556061adeaa8751b72:
> 
>   Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)
> 
> are available in the git repository at:
> 
>   git://git.pengutronix.de/git/pza/linux.git reset/for_v3.15

http://git.pengutronix.de/?p=pza/linux.git;a=shortlog;h=refs/heads/reset/for_v3.15

> for you to fetch changes up to fc0a5921561c71be2c334a335c1680f7930434d7:
> 
>   reset: Add of_reset_control_get (2014-02-03 10:19:40 +0100)
> 
> ----------------------------------------------------------------
> Maxime Ripard (1):
>       reset: Add of_reset_control_get
> 
> Philipp Zabel (1):
>       reset: allow drivers to request probe deferral
> 
> Rashika Kheria (1):
>       reset: Mark function as static and remove unused function in core.c
> 
>  drivers/reset/core.c  | 71
> +++++++++++++++++++++++----------------------------
>  include/linux/reset.h |  4 +++
>  2 files changed, 36 insertions(+), 39 deletions(-)

regards
Philipp
