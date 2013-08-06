From: horms@verge.net.au (Simon Horman)
Date: Tue, 6 Aug 2013 10:32:53 +0900
Subject: [GIT PULL 0/2 v2] Renesas ARM based SoC clocksource updates for
 v3.12
In-Reply-To: <51FF8212.5090406@linaro.org>
References: <1375667799-6327-1-git-send-email-horms+renesas@verge.net.au>
 <51FF8212.5090406@linaro.org>
Message-ID: <20130806013253.GB11356@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 05, 2013 at 12:44:34PM +0200, Daniel Lezcano wrote:
> On 08/05/2013 03:56 AM, Simon Horman wrote:
> > Hi Daniel,
> > 
> > please consider the following Renesas ARM based SoC clocksource updates
> > for v3.12.
> > 
> > 
> > The following changes since commit ad81f0545ef01ea651886dddac4bef6cec930092:
> > 
> >   Linux 3.11-rc1 (2013-07-14 15:18:27 -0700)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-clocksource-for-v3.12
> > 
> > for you to fetch changes up to 172705f8a40b6e72c53f8cceda079504ed71c4e0:
> > 
> >   clocksource: em_sti: Convert to devm_* managed helpers (2013-08-05 10:47:10 +0900)
> 
> Shall I pull your tree or applying the patches to my branch is ok also ?

I have a slight preference for you to pull the
renesas-clocksource-for-v3.12 tag of my tree.
But I am happy for you to apply the patches if you prefer.

> 
> Thanks
>   -- Daniel
> 
> > 
> > ----------------------------------------------------------------
> > Renesas ARM based SoC clocksource updates for v3.12
> > 
> > * Add support for CMT hardware with 32-bit control and counter registers
> > * em_sti: Convert to devm_* managed helpers
> > 
> > ----------------------------------------------------------------
> > Laurent Pinchart (1):
> >       clocksource: em_sti: Convert to devm_* managed helpers
> > 
> > Magnus Damm (1):
> >       clocksource: sh_cmt: 32-bit control register support
> > 
> >  drivers/clocksource/em_sti.c | 49 +++++++++++++------------------------------
> >  drivers/clocksource/sh_cmt.c | 50 +++++++++++++++++++++++++++++++-------------
> >  2 files changed, 50 insertions(+), 49 deletions(-)
> > 
> 
> 
> -- 
>  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
