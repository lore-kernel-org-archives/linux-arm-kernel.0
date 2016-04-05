From: gautamvivek1987@gmail.com (Vivek Gautam)
Date: Mon, 4 Apr 2016 21:54:12 -0700
Subject: [PATCH 1/2] phy: Group vendor specific phy drivers
In-Reply-To: <201604012318.jqf9PVXF%fengguang.wu@intel.com>
References: <1459510156-9147-1-git-send-email-gautam.vivek@samsung.com>
 <201604012318.jqf9PVXF%fengguang.wu@intel.com>
Message-ID: <CAFp+6iEKb3XB6mLv7vg=VsmLuUqrztALryr5qRL=38pM+35KEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 1, 2016 at 8:31 AM, kbuild test robot <lkp@intel.com> wrote:
> Hi Vivek,
>
> [auto build test ERROR on rockchip/for-next]
> [also build test ERROR on v4.6-rc1 next-20160401]
> [if your patch is applied to the wrong git tree, please drop us a note to help improving the system]
>
> url:    https://github.com/0day-ci/linux/commits/Vivek-Gautam/phy-Group-vendor-specific-phy-drivers/20160401-192920
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
> config: arm-allyesconfig (attached as .config)
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm
>
> All errors (new ones prefixed by >>):
>
>>> make[4]: *** No rule to make target 'drivers/phy/qcom/+=', needed by 'drivers/phy/qcom/built-in.o'.
>    make[4]: Target '__build' not remade because of errors.

will fix this.

>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


-- 
Best Regards
Vivek Gautam
Samsung, India
