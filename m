From: lkp@intel.com (kbuild test robot)
Date: Mon, 3 Apr 2017 15:35:39 +0800
Subject: [PATCH v2 4/5] serial: split generic UART driver helper
 functions into a separate file
In-Reply-To: <20170401222119.25106-5-nicolas.pitre@linaro.org>
Message-ID: <201704031536.HJVixVeq%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

[auto build test ERROR on tty/tty-testing]
[also build test ERROR on v4.11-rc5 next-20170331]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Nicolas-Pitre/minitty-a-minimal-TTY-layer-alternative-for-embedded-systems/20170403-103907
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
config: mips-rm200_defconfig (attached as .config)
compiler: mipsel-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=mips 

All errors (new ones prefixed by >>):

>> ERROR: "uart_port_lock_init" [drivers/tty/serial/serial_core.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 16937 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170403/7b3be7ac/attachment.gz>
