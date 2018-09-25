From: olof@lixom.net (Olof Johansson)
Date: Tue, 25 Sep 2018 12:49:24 -0700
Subject: [GIT PULL] updates for soc/fsl drivers for v4.20
In-Reply-To: <20180924222017.30522-1-leoyang.li@nxp.com>
References: <20180924222017.30522-1-leoyang.li@nxp.com>
Message-ID: <20180925194924.upvoooum2lynsg5a@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 24, 2018 at 05:20:17PM -0500, Li Yang wrote:
> Hi arm-soc maintainers,
> 
> Please pull soc/fsl drivers updates for v4.20.
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
>   git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git soc-fsl-next-v4.20
> 
> for you to fetch changes up to afa86d264a7ce62ba214bc7c6012e2129141421e:
> 
>   soc: fsl: dpio: remove redundant pointer 'priv' (2018-08-30 12:19:02 -0500)
> 
> ----------------------------------------------------------------
> NXP/FSL SoC driver updates for v4.20
> 
> - Use of_get_child_by_name helper for QE driver
> - Remove redundant pointer 'priv' for dpio driver

Good summary, thanks! Merged into next/drivers.


-Olof
