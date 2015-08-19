From: hramrach@gmail.com (Michal Suchanek)
Date: Wed, 19 Aug 2015 16:35:36 +0200
Subject: un4i-ss-cipher.c warning
Message-ID: <CAOMqctShdb9xEkBmuaQKfB1cwGupbfH5TS5ZB_P85Hwpn+4zAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

when building a kernel with sunxi crypto driver as merged into the
sinxi-wip branch I get a compiler warning.

I am not sure this is the latest version of the driver. It does not
seem to be in mainline yet.

Thanks

Michal

In file included from /scratch/build/linux/include/linux/printk.h:277:0,
                 from /scratch/build/linux/include/linux/kernel.h:13,
                 from /scratch/build/linux/include/linux/clk.h:16,
                 from
/scratch/build/linux/drivers/crypto/sunxi-ss/sun4i-ss.h:15,
                 from
/scratch/build/linux/drivers/crypto/sunxi-ss/sun4i-ss-cipher.c:17:
/scratch/build/linux/drivers/crypto/sunxi-ss/sun4i-ss-cipher.c: In
function ?sun4i_ss_cipher_poll?:
/scratch/build/linux/include/linux/dynamic_debug.h:86:3: warning:
?todo? may be used uninitialized in this function
[-Wmaybe-uninitialized]
   __dynamic_dev_dbg(&descriptor, dev, fmt, \
   ^
/scratch/build/linux/drivers/crypto/sunxi-ss/sun4i-ss-cipher.c:144:15:
note: ?todo? was declared here
  unsigned int todo;
