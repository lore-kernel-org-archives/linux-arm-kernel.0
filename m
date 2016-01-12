From: lkp@intel.com (kbuild test robot)
Date: Tue, 12 Jan 2016 20:54:39 +0800
Subject: [PATCH v2 2/2] mfd: add documentation for ACT8945A DT bindings
In-Reply-To: <1452585915-551-3-git-send-email-wenyou.yang@atmel.com>
Message-ID: <201601122010.TpAuObtz%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wenyou,

[auto build test ERROR on ljones-mfd/for-mfd-next]
[also build test ERROR on v4.4 next-20160111]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Wenyou-Yang/mfd-act8945a-add-Active-semi-ACT8945A-PMIC-MFD-driver/20160112-161159
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
config: x86_64-allmodconfig (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/built-in.o: In function `act8945a_i2c_probe':
>> act8945a.c:(.text+0x229476): undefined reference to `__devm_regmap_init_i2c'
   drivers/built-in.o: In function `act8945a_i2c_init':
>> act8945a.c:(.init.text+0x1a536): undefined reference to `i2c_register_driver'
   drivers/built-in.o: In function `act8945a_i2c_exit':
>> act8945a.c:(.exit.text+0x66f): undefined reference to `i2c_del_driver'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 51062 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160112/6b7364c9/attachment-0001.obj>
