From: leoyang.li@nxp.com (Leo Li)
Date: Tue, 25 Sep 2018 20:19:29 +0000
Subject: [GIT PULL] fixes for soc/fsl drivers for v4.19
In-Reply-To: <20180925194757.pp3jiltu36ih2wfo@localhost>
References: <20180924221954.30473-1-leoyang.li@nxp.com>
 <20180925194757.pp3jiltu36ih2wfo@localhost>
Message-ID: <AMSPR04MB503EAF5EF985E25D87190AA8F160@AMSPR04MB503.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Olof Johansson <olof@lixom.net>
> Sent: Tuesday, September 25, 2018 2:48 PM
> To: Leo Li <leoyang.li@nxp.com>
> Cc: arm at kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org; shawnguo at kernel.org
> Subject: Re: [GIT PULL] fixes for soc/fsl drivers for v4.19
> 
> Hi,
> 
> On Mon, Sep 24, 2018 at 05:19:54PM -0500, Li Yang wrote:
> > Hi arm-soc maintainers,
> >
> > Please pull soc/fsl drivers fixes for v4.19.
> >
> > Regards,
> > Leo
> >
> >
> > The following changes since commit
> 5b394b2ddf0347bef56e50c69a58773c94343ff3:
> >
> >   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git
> > tags/soc-fsl-fix-v4.19
> >
> > for you to fetch changes up to
> 3cb31b634052ed458922e0c8e2b4b093d7fb60b9:
> >
> >   soc: fsl: qe: Fix copy/paste bug in ucc_get_tdm_sync_shift()
> > (2018-09-17 16:01:46 -0500)
> >
> > ----------------------------------------------------------------
> > NXP/FSL SoC driver fixes for v4.19
> >
> > - Fix crash of qman_portal by deferring its probe if qman is not
> > probed
> > - Fix NULL pointer dereference by adding more checks in qman_portal
> > - Fix copy/paste bug in ucc_get_tdm_sync_shift()
> 
> Good summary, thanks!
> 
> However:
> 
> > Alexandre Belloni (2):
> >       soc: fsl: qbman: qman_portal: defer probing when qman is not
> > available
> 
> I think this fix has issues, I replied on the patch. Let me know if you want me to
> cherry-pick the other two fixes for now.

Thanks for the review.  Please help to cherry-pick the other two.  I will work with the patch author for an update for the first one.

Regards,
Leo
