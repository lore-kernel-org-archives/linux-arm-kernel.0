From: guodong.xu@linaro.org (Guodong Xu)
Date: Mon, 15 May 2017 17:37:43 +0800
Subject: [PATCH 1/3] arm64: dts: hi3660: add pcie node
In-Reply-To: <CAFGCpxwmuEKdc6FF=OmQz8tEipbcO+PjkwmywXLtY5=UxSeKvg@mail.gmail.com>
References: <20170515062745.70082-1-songxiaowei@hisilicon.com>
 <201705151738.ls8RIrFp%fengguang.wu@intel.com>
 <CAFGCpxwmuEKdc6FF=OmQz8tEipbcO+PjkwmywXLtY5=UxSeKvg@mail.gmail.com>
Message-ID: <CAFGCpxwiBky85WPiusic_UOtMq2VtaG2XC0VG2Hrgz7jtBScUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This PCIe node has dependencies on &crg_ctrl and &gpio11. However,
both of them are not appearing in mainline kernel tree yet. Sorry
about that. But I do have a plan to send all dts related changes to
maillist within this week, no later than this Wed (17/May). Would it
be possible you maintainers review this patch in parallel?

+Device tree maintainers.

-Guodong

>
> On Mon, May 15, 2017 at 5:18 PM, kbuild test robot <lkp@intel.com> wrote:
>>
>> Hi Song,
>>
>> [auto build test ERROR on pci/next]
>> [also build test ERROR on v4.12-rc1 next-20170515]
>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>>
>> url:    https://github.com/0day-ci/linux/commits/Song-Xiaowei/arm64-dts-hi3660-add-pcie-node/20170515-144035
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
>> config: arm64-defconfig (attached as .config)
>> compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
>> reproduce:
>>         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # save the attached .config to linux build tree
>>         make.cross ARCH=arm64
>>
>> All errors (new ones prefixed by >>):
>>
>> >> Error: arch/arm64/boot/dts/hisilicon/hi3660.dtsi:180.24-25 syntax error
>>    FATAL ERROR: Unable to parse input tree
>>
>> ---
>> 0-DAY kernel test infrastructure                Open Source Technology Center
>> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>
>
