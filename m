From: andy.gross@linaro.org (Andy Gross)
Date: Wed, 19 Apr 2017 15:29:52 -0500
Subject: [GIT PULL] Qualcomm Device Tree Changes for v4.12
In-Reply-To: <20170419134239.GU29219@localhost>
References: <1491533330-13570-1-git-send-email-andy.gross@linaro.org>
 <20170419134239.GU29219@localhost>
Message-ID: <20170419202952.GA9655@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 19, 2017 at 06:42:39AM -0700, Olof Johansson wrote:
> On Thu, Apr 06, 2017 at 09:48:50PM -0500, Andy Gross wrote:
> > The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:
> > 
> >   Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-dts-for-4.12
> > 
> > for you to fetch changes up to 21677ecca20151e61c3290ef37c5cd7afec60a5a:
> > 
> >   Revert "ARM: dts: qcom: msm8974: Add USB gadget nodes" (2017-04-06 18:48:53 -0500)
> > 
> > ----------------------------------------------------------------
> > Qualcomm Device Tree Changes for v4.12
> > 
> > * Add Coresight components for MSM8974
> > * Fixup MSM8974 ADSP XO clk and add RPMCC node
> > * Fix typo in APQ8060
> > * Add SDCs on MSM8660
> > * Revert MSM8974 USB gadget change due to issues
> 
> Merged, thanks. Should the USB gadget revert have been a fix for 4.11 instead?

I vacillated on that.  It broke one person using gadget for console, so I suppose it
should be considered a fix for 4.11.


Regards,

Andy
