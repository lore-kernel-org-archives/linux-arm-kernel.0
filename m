From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 9 Dec 2011 09:55:30 -0200
Subject: imx_v4_v5_defconfig: Need to specify LOADADDR
Message-ID: <CAOMZO5CkFx_kFJxDtyNsUVOfN9f-3X6daNvVD5BqUGLPnSvi7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On top of head mainline kernel I get:

make imx_v4_v5_defconfig
make uImage

....
  Kernel: arch/arm/boot/zImage is ready
multiple load addresses: 0x08008000 0xC0008000 0x80008000 0xA0008000
This is incompatible with uImages
Specify LOADADDR on the commandline to build an uImage
make[1]: *** [arch/arm/boot/uImage] Error 1
make: *** [uImage] Error 2
fabio at fabio-Latitude-E6410:~/linus/linux-2.6$

Is there a patch for this already?

Thanks,

Fabio Estevam
