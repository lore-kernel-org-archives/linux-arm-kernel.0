From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 16 Nov 2012 14:39:31 +0800
Subject: [PATCH 01/10] ARM: imx6q: print silicon version on boot
In-Reply-To: <20121116022346.GA2941@S2100-06.ap.freescale.net>
References: <1351005779-30347-1-git-send-email-shawn.guo@linaro.org>
 <1351005779-30347-2-git-send-email-shawn.guo@linaro.org>
 <72B629D8-8CD8-42E2-91A3-CF0532B15E5F@mentor.com>
 <20121116022346.GA2941@S2100-06.ap.freescale.net>
Message-ID: <20121116063929.GB2941@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 16, 2012 at 10:23:54AM +0800, Shawn Guo wrote:
> On Thu, Nov 15, 2012 at 06:09:31PM +0000, Moseley, Drew wrote:
> > On Oct 23, 2012, at 11:22 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> > > i.MX6Q has 3 revisions 1.0, 1.1 and 1.2.  Print revision on boot.
> > > 
> > > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > > ---
> > > arch/arm/mach-imx/mach-imx6q.c |   28 ++++++++++++++++++++++++++++
> > > 1 file changed, 28 insertions(+)
> > > 
> > 
> > Hi Shawn,
> > 
> > An addition to this patch to add some error checking.  Thoughts?
> > 
> It looks good.  I just squashed the changes into the original patch
> with your sob added.  Thanks.
> 
> Note, the patch series will probably postponed to 3.9 due to the
> dependency on other tree and the fact that I wait for a TO1.2 hardware
> to test the power gating state.
> 
It seems this particular patch is useful regardless of the cpuidle
support, so I will send this one for 3.8 anyway.

Shawn
