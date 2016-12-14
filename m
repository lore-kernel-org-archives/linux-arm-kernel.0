From: rob.rice@broadcom.com (Rob (William) Rice)
Date: Wed, 14 Dec 2016 10:00:22 -0500
Subject: [PATCH 3/3] crypto: brcm: Add Broadcom SPU driver DT entry.
In-Reply-To: <201612110810.BEVbRp0B%fengguang.wu@intel.com>
References: <201612110810.BEVbRp0B%fengguang.wu@intel.com>
Message-ID: <52897a59-f8e6-8df6-348d-c208f1b65575@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I will rebase to Herbert's latest when I submit v3 to address Mark 
Rutland's DT comments (and any others that come in).

Rob


On 12/10/2016 7:14 PM, kbuild test robot wrote:
> Hi Rob,
>
> [auto build test ERROR on cryptodev/master]
> [also build test ERROR on v4.9-rc8]
> [cannot apply to next-20161209]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Rob-Rice/crypto-brcm-DT-documentation-for-Broadcom-SPU-driver/20161202-010038
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
> config: arm64-defconfig (attached as .config)
> compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>          wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          make.cross ARCH=arm64
>
> All errors (new ones prefixed by >>):
>
>>> ERROR: Input tree has errors, aborting (use -f to force output)
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
