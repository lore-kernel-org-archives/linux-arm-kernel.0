From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Mon, 19 Oct 2015 10:41:07 +0100
Subject: [PATCH v3 14/24] arm64: Delay cpu feature capability checks
In-Reply-To: <201510180642.xwPchoyX%fengguang.wu@intel.com>
References: <201510180642.xwPchoyX%fengguang.wu@intel.com>
Message-ID: <5624BAB3.8050809@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/10/15 23:56, kbuild test robot wrote:
> Hi Suzuki,
>
> [auto build test ERROR on v4.3-rc5 -- if it's inappropriate base, please suggest rules for selecting the more suitable base]
>
> url:    https://github.com/0day-ci/linux/commits/Suzuki-K-Poulose/arm64-Consolidate-CPU-feature-handling/20151014-013504
> config: arm64-allnoconfig (attached as .config)
> reproduce:
>          wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          make.cross ARCH=arm64
>
> All errors (new ones prefixed by >>):


Thanks for the report, I have already fixed it for the next version.

Suzuki
