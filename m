From: lkp@intel.com (Fengguang Wu)
Date: Sat, 13 May 2017 08:44:15 +0800
Subject: [PATCH v3 1/9] arm: dts: mt7623: add mt7623-mt6323.dtsi file
In-Reply-To: <7f1d5fb3-5295-bb61-f21b-9d08bfaf070c@gmail.com>
References: <201705121837.eDU3hOId%fengguang.wu@intel.com>
 <7f1d5fb3-5295-bb61-f21b-9d08bfaf070c@gmail.com>
Message-ID: <20170513004415.5laehgg3mf7lcere@wfg-t540p.sh.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 12, 2017 at 05:46:06PM +0200, Matthias Brugger wrote:
>
>
>On 12/05/17 12:46, kbuild test robot wrote:
>> Hi John,
>>
>> [auto build test ERROR on robh/for-next]
>> [also build test ERROR on v4.11 next-20170512]
>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
>Mediatek dts patches should be tested against this branch:
>https://github.com/mbgg/linux-mediatek.git for-next

OK. I just send a patch for that.

>Thanks for maintaining the kbuild test robot.

You are welcome!

Thanks,
Fengguang

>>
>> url:    https://github.com/0day-ci/linux/commits/sean-wang-mediatek-com/arm-dts-extend-mt7623-support/20170512-165138
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
>> config: arm-at91_dt_defconfig (attached as .config)
>> compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
>> reproduce:
>>          wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # save the attached .config to linux build tree
>>          make.cross ARCH=arm
>>
>> All errors (new ones prefixed by >>):
>>
>>>> Error: arch/arm/boot/dts/mt7623-mt6323.dtsi:33.1-7 Label or path pwrap not found
>>>> Error: arch/arm/boot/dts/mt7623-mt6323.dtsi:261.1-6 Label or path mmc0 not found
>>>> Error: arch/arm/boot/dts/mt7623-mt6323.dtsi:266.1-6 Label or path mmc1 not found
>>     FATAL ERROR: Syntax error parsing input tree
>>
>> ---
>> 0-DAY kernel test infrastructure                Open Source Technology Center
>> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>>
