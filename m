From: fengguang.wu@intel.com (kbuild test robot)
Date: Fri, 20 Jan 2017 03:54:07 +0800
Subject: [arm:phy-cleanup 10/10]
 drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:30: error: type defaults
 to 'int' in declaration of 'MODULE_AUTHOR'
Message-ID: <201701200354.rfi6J6tv%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm.git phy-cleanup
head:   a8d93f6890893686b4e5f5e8e4ae39c64af2391d
commit: a8d93f6890893686b4e5f5e8e4ae39c64af2391d [10/10] net: dsa: remove unnecessary phy*.h includes
config: x86_64-randconfig-a0-01200234 (attached as .config)
compiler: gcc-4.4 (Debian 4.4.7-8) 4.4.7
reproduce:
        git checkout a8d93f6890893686b4e5f5e8e4ae39c64af2391d
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:30: error: expected declaration specifiers or '...' before string constant
   drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:30: warning: data definition has no type or storage class
>> drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:30: error: type defaults to 'int' in declaration of 'MODULE_AUTHOR'
>> drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:30: error: function declaration isn't a prototype
   drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:31: error: expected declaration specifiers or '...' before string constant
   drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:31: warning: data definition has no type or storage class
>> drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:31: error: type defaults to 'int' in declaration of 'MODULE_DESCRIPTION'
   drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:31: error: function declaration isn't a prototype
   drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:32: error: expected declaration specifiers or '...' before string constant
   drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:32: warning: data definition has no type or storage class
>> drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:32: error: type defaults to 'int' in declaration of 'MODULE_LICENSE'
   drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:32: error: function declaration isn't a prototype
   drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:33: error: expected declaration specifiers or '...' before string constant
   drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:33: warning: data definition has no type or storage class
>> drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:33: error: type defaults to 'int' in declaration of 'MODULE_VERSION'
   drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:33: error: function declaration isn't a prototype
   drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:36: error: expected ')' before 'int'
   drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:37: error: expected ')' before string constant
   drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:325: warning: data definition has no type or storage class
   drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:325: error: type defaults to 'int' in declaration of 'MODULE_DEVICE_TABLE'
   drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:325: warning: parameter names (without types) in function declaration
   drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:3250: warning: data definition has no type or storage class
   drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:3250: error: type defaults to 'int' in declaration of 'module_init'
   drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:3250: warning: parameter names (without types) in function declaration
   drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:3251: warning: data definition has no type or storage class
   drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:3251: error: type defaults to 'int' in declaration of 'module_exit'
   drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:3251: warning: parameter names (without types) in function declaration
   cc1: warning: unrecognized command line option "-Wno-maybe-uninitialized"
--
   drivers/net/ethernet/cavium/liquidio/lio_main.c:36: error: expected declaration specifiers or '...' before string constant
   drivers/net/ethernet/cavium/liquidio/lio_main.c:36: warning: data definition has no type or storage class
>> drivers/net/ethernet/cavium/liquidio/lio_main.c:36: error: type defaults to 'int' in declaration of 'MODULE_AUTHOR'
>> drivers/net/ethernet/cavium/liquidio/lio_main.c:36: error: function declaration isn't a prototype
   drivers/net/ethernet/cavium/liquidio/lio_main.c:37: error: expected declaration specifiers or '...' before string constant
   drivers/net/ethernet/cavium/liquidio/lio_main.c:37: warning: data definition has no type or storage class
>> drivers/net/ethernet/cavium/liquidio/lio_main.c:37: error: type defaults to 'int' in declaration of 'MODULE_DESCRIPTION'
   drivers/net/ethernet/cavium/liquidio/lio_main.c:37: error: function declaration isn't a prototype
   drivers/net/ethernet/cavium/liquidio/lio_main.c:38: error: expected declaration specifiers or '...' before string constant
   drivers/net/ethernet/cavium/liquidio/lio_main.c:38: warning: data definition has no type or storage class
>> drivers/net/ethernet/cavium/liquidio/lio_main.c:38: error: type defaults to 'int' in declaration of 'MODULE_LICENSE'
   drivers/net/ethernet/cavium/liquidio/lio_main.c:38: error: function declaration isn't a prototype
   drivers/net/ethernet/cavium/liquidio/lio_main.c:39: error: expected declaration specifiers or '...' before string constant
   drivers/net/ethernet/cavium/liquidio/lio_main.c:39: warning: data definition has no type or storage class
>> drivers/net/ethernet/cavium/liquidio/lio_main.c:39: error: type defaults to 'int' in declaration of 'MODULE_VERSION'
   drivers/net/ethernet/cavium/liquidio/lio_main.c:39: error: function declaration isn't a prototype
   drivers/net/ethernet/cavium/liquidio/lio_main.c:40: error: expected declaration specifiers or '...' before string constant
   drivers/net/ethernet/cavium/liquidio/lio_main.c:40: warning: data definition has no type or storage class
>> drivers/net/ethernet/cavium/liquidio/lio_main.c:40: error: type defaults to 'int' in declaration of 'MODULE_FIRMWARE'
   drivers/net/ethernet/cavium/liquidio/lio_main.c:40: error: function declaration isn't a prototype
   drivers/net/ethernet/cavium/liquidio/lio_main.c:41: error: expected declaration specifiers or '...' before string constant
   drivers/net/ethernet/cavium/liquidio/lio_main.c:41: warning: data definition has no type or storage class
   drivers/net/ethernet/cavium/liquidio/lio_main.c:41: error: type defaults to 'int' in declaration of 'MODULE_FIRMWARE'
   drivers/net/ethernet/cavium/liquidio/lio_main.c:41: error: function declaration isn't a prototype
   drivers/net/ethernet/cavium/liquidio/lio_main.c:42: error: expected declaration specifiers or '...' before string constant
   drivers/net/ethernet/cavium/liquidio/lio_main.c:42: warning: data definition has no type or storage class
   drivers/net/ethernet/cavium/liquidio/lio_main.c:42: error: type defaults to 'int' in declaration of 'MODULE_FIRMWARE'
   drivers/net/ethernet/cavium/liquidio/lio_main.c:42: error: function declaration isn't a prototype
   drivers/net/ethernet/cavium/liquidio/lio_main.c:43: error: expected declaration specifiers or '...' before string constant
   drivers/net/ethernet/cavium/liquidio/lio_main.c:43: warning: data definition has no type or storage class
   drivers/net/ethernet/cavium/liquidio/lio_main.c:43: error: type defaults to 'int' in declaration of 'MODULE_FIRMWARE'
   drivers/net/ethernet/cavium/liquidio/lio_main.c:43: error: function declaration isn't a prototype
   drivers/net/ethernet/cavium/liquidio/lio_main.c:46: error: expected ')' before 'int'
   drivers/net/ethernet/cavium/liquidio/lio_main.c:48: error: expected ')' before string constant
   drivers/net/ethernet/cavium/liquidio/lio_main.c:53: error: expected ')' before 'int'
   drivers/net/ethernet/cavium/liquidio/lio_main.c:54: error: expected ')' before string constant
   drivers/net/ethernet/cavium/liquidio/lio_main.c:57: error: expected ')' before 'sizeof'
   drivers/net/ethernet/cavium/liquidio/lio_main.c:58: error: expected ')' before string constant
   drivers/net/ethernet/cavium/liquidio/lio_main.c:498: warning: data definition has no type or storage class
   drivers/net/ethernet/cavium/liquidio/lio_main.c:498: error: type defaults to 'int' in declaration of 'MODULE_DEVICE_TABLE'
   drivers/net/ethernet/cavium/liquidio/lio_main.c:498: warning: parameter names (without types) in function declaration
   drivers/net/ethernet/cavium/liquidio/lio_main.c: In function 'octeon_recv_vf_drv_notice':
   drivers/net/ethernet/cavium/liquidio/lio_main.c:4393: error: implicit declaration of function 'try_module_get'
   drivers/net/ethernet/cavium/liquidio/lio_main.c:4400: error: implicit declaration of function 'module_put'
   drivers/net/ethernet/cavium/liquidio/lio_main.c: At top level:
   drivers/net/ethernet/cavium/liquidio/lio_main.c:4670: warning: data definition has no type or storage class
   drivers/net/ethernet/cavium/liquidio/lio_main.c:4670: error: type defaults to 'int' in declaration of 'module_init'
   drivers/net/ethernet/cavium/liquidio/lio_main.c:4670: warning: parameter names (without types) in function declaration
   drivers/net/ethernet/cavium/liquidio/lio_main.c:4671: warning: data definition has no type or storage class
   drivers/net/ethernet/cavium/liquidio/lio_main.c:4671: error: type defaults to 'int' in declaration of 'module_exit'
   drivers/net/ethernet/cavium/liquidio/lio_main.c:4671: warning: parameter names (without types) in function declaration
   cc1: warning: unrecognized command line option "-Wno-maybe-uninitialized"

vim +30 drivers/net/ethernet/cavium/liquidio/lio_vf_main.c

111fc64a Raghu Vatsavayi 2016-11-28  24  #include "octeon_device.h"
846b4687 Raghu Vatsavayi 2016-12-07  25  #include "octeon_nic.h"
69c69da3 Raghu Vatsavayi 2016-11-28  26  #include "octeon_main.h"
846b4687 Raghu Vatsavayi 2016-12-07  27  #include "octeon_network.h"
69c69da3 Raghu Vatsavayi 2016-11-28  28  #include "cn23xx_vf_device.h"
111fc64a Raghu Vatsavayi 2016-11-28  29  
111fc64a Raghu Vatsavayi 2016-11-28 @30  MODULE_AUTHOR("Cavium Networks, <support@cavium.com>");
111fc64a Raghu Vatsavayi 2016-11-28 @31  MODULE_DESCRIPTION("Cavium LiquidIO Intelligent Server Adapter Virtual Function Driver");
111fc64a Raghu Vatsavayi 2016-11-28 @32  MODULE_LICENSE("GPL");
111fc64a Raghu Vatsavayi 2016-11-28 @33  MODULE_VERSION(LIQUIDIO_VERSION);
111fc64a Raghu Vatsavayi 2016-11-28  34  
846b4687 Raghu Vatsavayi 2016-12-07  35  static int debug = -1;
846b4687 Raghu Vatsavayi 2016-12-07  36  module_param(debug, int, 0644);

:::::: The code at line 30 was first introduced by commit
:::::: 111fc64a237f231bc2d3187bdf8358eb7966e6a9 liquidio CN23XX: VF registration

:::::: TO: Raghu Vatsavayi <rvatsavayi@caviumnetworks.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 34807 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170120/143c570b/attachment-0001.gz>
