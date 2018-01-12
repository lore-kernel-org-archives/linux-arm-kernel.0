From: olof@lixom.net (Olof Johansson)
Date: Thu, 11 Jan 2018 18:02:17 -0800
Subject: [GIT PULL] updates to soc/fsl drivers for v4.16
In-Reply-To: <1515628596-4715-1-git-send-email-leoyang.li@nxp.com>
References: <1515628596-4715-1-git-send-email-leoyang.li@nxp.com>
Message-ID: <20180112020217.tqdjt3voqimr3ptx@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 10, 2018 at 05:56:36PM -0600, Li Yang wrote:
> Hi arm-soc maintainer,
> 
> Please merge the following tag to get updates to the soc/fsl/guts driver
> for support of additional SoCs and more error path handling.
> 
> Thanks,
> Leo
> 
> 
> The following changes since commit b2cd1df66037e7c4697c7e40496bf7e4a5e16a2d:
> 
>   Linux 4.15-rc7 (2018-01-07 14:22:41 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git tags/soc-fsl-for-4.16
> 
> for you to fetch changes up to 00ce0a2304014c73c2b7915215c7b3c73e2a25aa:
> 
>   soc: fsl: guts: Add a NULL check for devm_kasprintf() (2018-01-10 16:54:26 -0600)

1) This is based on much too new a release
2) the fact that it's based on this new a release makes me suspect it hasn't
   been sitting in linux-next either, at least not since before -rc7.


Conclusion: Please resend post merge window and we'll queue it up for the
next release. If the bugfix should go in sooner than that, I can cherry-pick
that into our fixes. Let me know.


-Olof
