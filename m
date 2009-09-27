From: walsimou@walsimou.com (Gaye Abdoulaye Walsimou)
Date: Sun, 27 Sep 2009 19:41:06 +0200
Subject: Please fix this build error in mini2440 board
Message-ID: <4ABFA3B2.7020401@walsimou.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello list,
Please fix this[1] build error in mini2440 board, due to missing "select
S3C_DEV_USB_HOST".
I reported this weeks ago, and if IIRC many merge windows passed.

Thanks,
Best regards

[1]
arch/arm/mach-s3c2440/built-in.o:(.init.data+0x660): undefined reference
to `s3c_device_usb'
make: *** [.tmp_vmlinux1] Error 1
