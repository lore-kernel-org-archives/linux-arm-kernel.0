From: olof@lixom.net (Olof Johansson)
Date: Tue, 23 Sep 2014 22:24:25 -0700
Subject: [GIT PULL][for 3.18]pull request for hisilicon hip04 soc and D01
 board updates
In-Reply-To: <5412A169.5020308@hisilicon.com>
References: <5412A169.5020308@hisilicon.com>
Message-ID: <20140924052425.GD30340@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 12, 2014 at 03:31:53PM +0800, xuwei wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please help to merge pull request for hisilicon hip04 soc and D01 board updates for 3.18. 
> Thanks!
> 
> Best Regards,
> Wei
> 
> 
> The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:
> 
>   Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)
> 
> are available in the git repository at:
> 
>   git://github.com/hisilicon/linux-hisi.git tags/D01-for-3.18
> 
> for you to fetch changes up to c9a1df48a97ac9141540f177e4293a9966348f8c:
> 
>   ARM: debug: add HiP04 debug uart (2014-09-03 14:10:46 +0100)
> 
> ----------------------------------------------------------------
> ARM: mach-hisi: Hisilicon hip04 soc and D01 board updates for 3.18
> 
> - Add the CONFIG_MCPM_QUAD_CLUSTER configuration to enlarge cluster number from 2 to 4
> - Enable MCPM on HiP04 SoC
> - Enable 16 cores on HiP04 SoC
> - Add platform & Fabric controller devicetree binding document for HiP04 SoC
> - Add hip04.dtsi & hip04-d01.dts for hip04 SoC platform and D01 board
> - Enable HiP04 SoC in both hi3xxx_defconfig & multi_v7_defconfig
> - Add the support of Hisilicon HiP04 debug uart

Hi,

Merged this into next/soc. Two minor comments:

1) I applied a patch on top to fix sort order of the debug uart config entries,
HIP04 was added before HIGHBANK. But the previous hisi config there was also added
out of order.

2) Would you mind configuring your mailer to use your name as name? Right
now it says "xuwei" instead of "Wei Xu" on your email address. It's correct on the git
config, so it's probably just your mail config.


Thanks!


-Olof
