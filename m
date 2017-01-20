From: lkp@intel.com (kbuild test robot)
Date: Fri, 20 Jan 2017 13:46:56 +0800
Subject: [PATCH 2/2] security: Change name of CONFIG_DEBUG_SET_MODULE_RONX
In-Reply-To: <1484789346-21012-3-git-send-email-labbott@redhat.com>
Message-ID: <201701201304.jGPDDSxI%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laura,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.10-rc4]
[cannot apply to next-20170119]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Laura-Abbott/Better-hardening-names/20170119-200343
config: i386-randconfig-c0-01201130 (attached as .config)
compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   arch/x86/built-in.o: In function `ftrace_arch_code_modify_prepare':
>> (.text+0x3fcb7): undefined reference to `set_all_modules_text_rw'
   arch/x86/built-in.o: In function `ftrace_arch_code_modify_post_process':
>> (.text+0x3fcc3): undefined reference to `set_all_modules_text_ro'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 29640 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170120/5e68f258/attachment-0001.gz>
