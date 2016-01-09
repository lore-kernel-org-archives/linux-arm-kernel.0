From: lkp@intel.com (kbuild test robot)
Date: Sat, 9 Jan 2016 14:24:44 +0800
Subject: [PATCH v5 1/6] clk: hisilicon: add CRG driver for hi3519 soc
In-Reply-To: <1452219400-32478-2-git-send-email-xuejiancheng@huawei.com>
Message-ID: <201601091407.Ep5LfNku%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jiancheng,

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.4-rc8 next-20160108]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Jiancheng-Xue/ARM-hisi-Add-initial-support-including-clock-driver-for-Hi3519-soc/20160108-103510
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux for-next
config: arm-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> ERROR: "hisi_reset_init" [drivers/clk/hisilicon/clk-hi3519.ko] undefined!
>> ERROR: "hisi_clk_register_gate" [drivers/clk/hisilicon/clk-hi3519.ko] undefined!
>> ERROR: "hisi_clk_register_mux" [drivers/clk/hisilicon/clk-hi3519.ko] undefined!
>> ERROR: "hisi_clk_register_fixed_rate" [drivers/clk/hisilicon/clk-hi3519.ko] undefined!
>> ERROR: "hisi_clk_init" [drivers/clk/hisilicon/clk-hi3519.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 54589 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160109/57ae82aa/attachment-0001.obj>
