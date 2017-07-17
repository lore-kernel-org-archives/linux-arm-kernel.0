From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 17 Jul 2017 17:42:26 +0200
Subject: [PATCH] iommu/exynos: Replace non-existing big-endian Kconfig
 option
In-Reply-To: <201707172340.xpsuGzYj%fengguang.wu@intel.com>
References: <1500270422-4805-1-git-send-email-krzk@kernel.org>
 <201707172340.xpsuGzYj%fengguang.wu@intel.com>
Message-ID: <CAJKOXPcQuCE4N=MuJPu_4AEcx7pgd-8VyRxese7D_nBQE9o7Cg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 17, 2017 at 5:25 PM, kbuild test robot <lkp@intel.com> wrote:
> Hi Krzysztof,
>
> [auto build test WARNING on iommu/next]
> [also build test WARNING on v4.13-rc1 next-20170717]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Krzysztof-Kozlowski/iommu-exynos-Replace-non-existing-big-endian-Kconfig-option/20170717-141202
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
> config: arm-allmodconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm
>
> All warnings (new ones prefixed by >>):
>
>>> drivers//iommu/exynos-iommu.c:58:2: warning: #warning "revisit driver if we can enable big-endian ptes" [-Wcpp]
>     #warning "revisit driver if we can enable big-endian ptes"
>      ^~~~~~~

FYI,
Everything is fine, this is an expected warning which I am bringing
back to life.

Best regards,
Krzysztof
