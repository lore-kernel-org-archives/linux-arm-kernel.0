From: lkp@intel.com (kbuild test robot)
Date: Sat, 7 Jul 2018 18:45:12 +0800
Subject: [PATCH net-next 1/6] net: mvneta: remove data pointer usage from
 device_node structure
In-Reply-To: <20180706131949.2684-2-gregory.clement@bootlin.com>
References: <20180706131949.2684-2-gregory.clement@bootlin.com>
Message-ID: <201807071855.daaJfGJb%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

I love your patch! Yet something to improve:

[auto build test ERROR on net-next/master]

url:    https://github.com/0day-ci/linux/commits/Gregory-CLEMENT/Few-improvements-on-mvneta/20180707-034934
config: i386-allmodconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

>> ERROR: "mvneta_bm_get" [drivers/net/ethernet/marvell/mvneta.ko] undefined!
>> ERROR: "mvneta_bm_put" [drivers/net/ethernet/marvell/mvneta.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 64043 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180707/726b1cd2/attachment-0001.gz>
