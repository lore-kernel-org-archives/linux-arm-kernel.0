From: lkp@intel.com (kbuild test robot)
Date: Tue, 12 Jan 2016 07:24:09 +0800
Subject: [RESEND][PATCHv2 2/3] staging: ion: Add files for parsing the
 devicetree
In-Reply-To: <1452548364-9522-3-git-send-email-laura@labbott.name>
Message-ID: <201601120746.hJPgqCqR%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laura,

[auto build test ERROR on v4.4-rc8]
[cannot apply to staging/staging-testing next-20160111]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Laura-Abbott/Devicetree-bindings-for-Ion/20160112-054709
config: x86_64-allmodconfig (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

>> make[5]: *** No rule to make target 'drivers/staging/android/ion/ion_physmem.o', needed by 'drivers/staging/android/ion/built-in.o'.
   make[5]: Target '__build' not remade because of errors.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 51055 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160112/84cc6eb8/attachment-0001.obj>
