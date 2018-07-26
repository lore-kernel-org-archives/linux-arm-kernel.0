From: olof@lixom.net (Olof Johansson)
Date: Thu, 26 Jul 2018 00:16:35 -0700
Subject: [GIT PULL] updates to soc/fsl drivers for v4.19
In-Reply-To: <1532469595-12060-1-git-send-email-leoyang.li@nxp.com>
References: <1532469595-12060-1-git-send-email-leoyang.li@nxp.com>
Message-ID: <20180726071635.whbiz5onokhvcjb4@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 24, 2018 at 04:59:55PM -0500, Li Yang wrote:
> Hi arm-soc maintainers,
> 
> Please merge the following tag to get updates to the soc/fsl drivers:
>   Moves DPAA2 DPIO driver from staging to fsl/soc
>   Adds multiple-pin support to QE gpio driver
> 
> Regards,
> Leo
> 
> 
> The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
> 
>   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git tags/soc-fsl-for-4.19
> 
> for you to fetch changes up to 4625210899095195600062ff8542f37a1c9f5dd4:
> 
>   soc: fsl: cleanup Kconfig menu (2018-07-24 16:19:16 -0500)
> 
> ----------------------------------------------------------------
> Various updates to soc/fsl for 4.19
> 
> Moves DPAA2 DPIO driver from staging to fsl/soc
> Adds multiple-pin support to QE gpio driver
> 
> ----------------------------------------------------------------
> Horia Geant? (1):
>       staging: fsl-dpaa2: eth: move generic FD defines to DPIO
> 
> Joakim Tjernlund (1):
>       soc: fsl: qe: gpio: Add qe_gpio_set_multiple
> 
> Li Yang (1):
>       soc: fsl: cleanup Kconfig menu
> 
> Roy Pledge (3):
>       staging: fsl-mc: Move DPIO from staging to drivers/soc/fsl
>       staging: fsl-mc: Remove remaining files
>       soc: fsl: dpio: Convert DPIO documentation to .rst

Merged, thanks.


-Olof
