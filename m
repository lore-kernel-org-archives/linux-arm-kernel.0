From: lkp@intel.com (kbuild test robot)
Date: Thu, 24 Nov 2016 12:46:55 +0800
Subject: [PATCH 4/4] serial: imx: Add LED trigger support
In-Reply-To: <20161123100106.15969-5-s.hauer@pengutronix.de>
Message-ID: <201611241248.FSeTT57Y%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

[auto build test ERROR on tty/tty-testing]
[also build test ERROR on v4.9-rc6 next-20161123]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Sascha-Hauer/serial-core-Add-LED-trigger-support/20161124-010846
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
config: s390-allmodconfig (attached as .config)
compiler: s390x-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=s390 

All errors (new ones prefixed by >>):

>> ERROR: "uart_remove_led_triggers" [drivers/tty/serial/imx.ko] undefined!
>> ERROR: "uart_led_trigger_rx" [drivers/tty/serial/imx.ko] undefined!
>> ERROR: "uart_led_trigger_tx" [drivers/tty/serial/imx.ko] undefined!
>> ERROR: "uart_add_led_triggers" [drivers/tty/serial/imx.ko] undefined!
   ERROR: "uart_led_trigger_rx" [drivers/tty/serial/8250/8250_base.ko] undefined!
   ERROR: "uart_led_trigger_tx" [drivers/tty/serial/8250/8250_base.ko] undefined!
   ERROR: "uart_remove_led_triggers" [drivers/tty/serial/8250/8250.ko] undefined!
   ERROR: "uart_add_led_triggers" [drivers/tty/serial/8250/8250.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 43170 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161124/34007947/attachment-0001.gz>
