From: leoyang.li@nxp.com (Leo Li)
Date: Fri, 12 Jan 2018 19:28:03 +0000
Subject: [GIT PULL] updates to soc/fsl drivers for v4.16
In-Reply-To: <20180112020217.tqdjt3voqimr3ptx@localhost>
References: <1515628596-4715-1-git-send-email-leoyang.li@nxp.com>
 <20180112020217.tqdjt3voqimr3ptx@localhost>
Message-ID: <AM4PR0401MB1699179D81FBB37456325AEA8F170@AM4PR0401MB1699.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Olof Johansson [mailto:olof at lixom.net]
> Sent: Thursday, January 11, 2018 8:02 PM
> To: Leo Li <leoyang.li@nxp.com>
> Cc: arm at kernel.org; shawnguo at kernel.org; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [GIT PULL] updates to soc/fsl drivers for v4.16
> 
> On Wed, Jan 10, 2018 at 05:56:36PM -0600, Li Yang wrote:
> > Hi arm-soc maintainer,
> >
> > Please merge the following tag to get updates to the soc/fsl/guts
> > driver for support of additional SoCs and more error path handling.
> >
> > Thanks,
> > Leo
> >
> >
> > The following changes since commit
> b2cd1df66037e7c4697c7e40496bf7e4a5e16a2d:
> >
> >   Linux 4.15-rc7 (2018-01-07 14:22:41 -0800)
> >
> > are available in the git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git
> > tags/soc-fsl-for-4.16
> >
> > for you to fetch changes up to
> 00ce0a2304014c73c2b7915215c7b3c73e2a25aa:
> >
> >   soc: fsl: guts: Add a NULL check for devm_kasprintf() (2018-01-10
> > 16:54:26 -0600)
> 
> 1) This is based on much too new a release

The branch was created and the first patch was applied quite a while ago.  The second patch is relatively new but very straightforward.  I rebased the branch to -rc7 just before sending the pull request thinking it would be easier for you to merge.  If that is not a preferred action, I will not do that again in the future.

> 2) the fact that it's based on this new a release makes me suspect it hasn't
>    been sitting in linux-next either, at least not since before -rc7.

My tree is not being merged by the Linux-next right now.  So you think we should ask Linux-next to add my tree too?

> 
> 
> Conclusion: Please resend post merge window and we'll queue it up for the
> next release. If the bugfix should go in sooner than that, I can cherry-pick
> that into our fixes. Let me know.

I know the pull request is coming a little bit late.  But the two small patches are really simple and straightforward.  They are not technically a fix but it will be really helpful if you can take it in this merge window.  And going forward, what is your preferred time frame to send pull request to for-next?

Regards,
Leo
