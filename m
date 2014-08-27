From: olof@lixom.net (Olof Johansson)
Date: Wed, 27 Aug 2014 15:03:10 -0700
Subject: [GIT PULL][for v3.17] pull request on fixing PXA DT
In-Reply-To: <CAN1soZz_j2=DzazzLC1FV+kDtyhHRb4CYY3=vm+OmwEhQ1SqWA@mail.gmail.com>
References: <CAN1soZz_j2=DzazzLC1FV+kDtyhHRb4CYY3=vm+OmwEhQ1SqWA@mail.gmail.com>
Message-ID: <20140827220310.GA13392@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 25, 2014 at 03:37:13PM +0800, Haojian Zhuang wrote:
> Hi Olof, Arnd, Kevin,
> 
> Please help to merge the pull request from PXA git tree.
> 
> Best Regards
> Haojian
> 
> The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:
> 
>   Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/hzhuang1/linux.git
> tags/fix-pxa-dt-v3.17
> 
> for you to fetch changes up to 960a1042caf5e2f96fe9ddff98a4735aa9288080:
> 
>   ARM: pxa3xx: provide specific platform_devices for all ssp ports
> (2014-08-25 15:10:54 +0800)
> 
> ----------------------------------------------------------------
> Fix DT bindings on PXA MMC/USB/SOUND
> 
> ----------------------------------------------------------------
> Daniel Mack (4):
>       ARM: pxa: dts: fix mmc controller compatible string
>       ARM: pxa: dts: fix ohci controller compatible string
>       ARM: pxa: ssp: provide platform_device_id for PXA3xx
>       ARM: pxa3xx: provide specific platform_devices for all ssp ports

Hi,

I replied to one of the compatible string emails -- those should be done
for 3.18 and the driver regression needs to be fixed.

For the latter two fixes, what's not explained in the changelogs is what
is actually broken. How does this breakage affect a user? If it is a
regression, please also include what caused the breakage.


-Olof
