From: lkp@intel.com (kbuild test robot)
Date: Wed, 7 Oct 2015 05:29:32 +0800
Subject: [RFC][PATCH 2/2] staging: ion: Add files for parsing the
 devicetree (WIP)
In-Reply-To: <1444164433-9107-3-git-send-email-labbott@fedoraproject.org>
Message-ID: <201510070535.v0amqMb0%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laura,

[auto build test WARNING on v4.3-rc4 -- if it's inappropriate base, please ignore]

reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/staging/android/ion/ion_of.c:31:5: sparse: symbol 'ion_parse_dt_heap_common' was not declared. Should it be static?
>> drivers/staging/android/ion/ion_of.c:70:5: sparse: symbol 'ion_setup_heap_common' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
