From: olof@lixom.net (Olof Johansson)
Date: Wed, 19 Apr 2017 05:37:09 -0700
Subject: [GIT PULL] Allwinner DT changes for 4.12
In-Reply-To: <20170406085810.lhizqmi65h2jats3@lukather>
References: <20170406085810.lhizqmi65h2jats3@lukather>
Message-ID: <20170419123709.GR17004@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 06, 2017 at 10:58:10AM +0200, Maxime Ripard wrote:
> Hi Arnd, Olof,
> 
> Please pull the following DT changes for the next merge window.
> 
> Thanks!
> Maxime
> 
> The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:
> 
>   Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-dt-for-4.12
> 
> for you to fetch changes up to 367d2b0cb15dfbfa7243b200957c3c6b86276b54:
> 
>   ARM: sun8i: sina33: add highest OPP of CPUs (2017-04-05 14:11:36 +0200)
> 
> ----------------------------------------------------------------
> Allwinner DT changes for 4.12
> 
> As usual a number of changes, among which:
>   - All the sun5i DTSI has been reworked based on the new documentation and
>     the IPs that are actually found in all those SoCs. Part of that rework
>     also brought the GR8 DTSI to include sun5i.dtsi
>   - Mali devfreq and thermal throttling support on the A33
>   - AC power supplies for the AXP209 and AXP22X PMIC
>   - CAN support for the A20
>   - CPUFreq-based thermal throttling for the A33
>   - New board: NanoPi NEO Air

Merged, thanks.


-Olof
