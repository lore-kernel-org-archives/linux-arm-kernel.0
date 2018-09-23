From: olof@lixom.net (Olof Johansson)
Date: Sun, 23 Sep 2018 05:37:04 -0700
Subject: [GIT PULL] fixes for soc/fsl drivers for v4.19
In-Reply-To: <20180920165656.31902-1-leoyang.li@nxp.com>
References: <20180920165656.31902-1-leoyang.li@nxp.com>
Message-ID: <20180923123704.r47aywqfhor3ma74@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Li,

On Thu, Sep 20, 2018 at 11:56:56AM -0500, Li Yang wrote:
> Hi arm-soc maintainers,
> 
> Please merge the following fixes for soc/fsl drivers.
> 
> Regards,
> Leo
> 
> The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
> 
>   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git tags/soc-fsl-fixes-for-4.19
> 
> for you to fetch changes up to 3cb31b634052ed458922e0c8e2b4b093d7fb60b9:
> 
>   soc: fsl: qe: Fix copy/paste bug in ucc_get_tdm_sync_shift() (2018-09-17 16:01:46 -0500)
> 
> ----------------------------------------------------------------
> soc/fsl fixes for 4.19

Please spend a bit of effort on writing up the tag for all pull requests, even
fixes. For fixes in particular, just as with the patch descriptions we want the
pull request to contain some brief information to what the bug is and why the
fix is needed.

Care to give this another go with a new tag description, please?


Thanks,

Olof
