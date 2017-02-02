From: lkp@intel.com (kbuild test robot)
Date: Thu, 2 Feb 2017 10:34:00 +0800
Subject: [PATCH V8 09/10] trace, ras: add ARM processor error trace event
In-Reply-To: <1485969413-23577-10-git-send-email-tbaicar@codeaurora.org>
Message-ID: <201702021014.xd63mfiV%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tyler,

[auto build test ERROR on pm/linux-next]
[also build test ERROR on v4.10-rc6 next-20170201]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Tyler-Baicar/Add-UEFI-2-6-and-ACPI-6-1-updates-for-RAS-on-ARM64/20170202-020320
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: x86_64-randconfig-r0-02020102 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/built-in.o: In function `ghes_do_proc.isra.9':
>> ghes.c:(.text+0x92fda): undefined reference to `__tracepoint_arm_event'
   ghes.c:(.text+0x9300a): undefined reference to `__tracepoint_arm_event'
   ghes.c:(.text+0x93054): undefined reference to `__tracepoint_arm_event'
   ghes.c:(.text+0x93083): undefined reference to `__tracepoint_unknown_sec_event'
   ghes.c:(.text+0x930b8): undefined reference to `__tracepoint_unknown_sec_event'
   ghes.c:(.text+0x93121): undefined reference to `__tracepoint_unknown_sec_event'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 25871 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170202/00eeb16c/attachment-0001.gz>
