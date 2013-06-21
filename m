From: vijay.kilari@gmail.com (Vijay Kilari)
Date: Fri, 21 Jun 2013 17:02:34 +0530
Subject: ARM : Kexec fails with kernel 3.10 on ARM Versatile TC2
Message-ID: <CALicx6sYQ19Jx_HuwLeoXNiNFSNvCUc+XKMZsf6vAasPhxOVSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

  With Kernel 3.10 SMP kernel, on versatile TC2 board, Kexec hangs.


arm-cortex-a15 login: kexec -f /boot/uImage
--command-line="root=/dev/nfs rw ip=bootp console=ttyS0,38400n8"
Modified cmdline:root=/dev/nfs rw ip=bootp console=ttyS0,38400n8
Starting new kernel
Bye!
Uncompressing Linux... done, booting the kernel

Can you please provide your inputs?

Thanks & Regards
Vijay
