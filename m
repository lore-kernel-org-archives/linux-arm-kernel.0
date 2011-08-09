From: eric.miao@linaro.org (Eric Miao)
Date: Tue, 9 Aug 2011 23:58:05 +0800
Subject: Building failure of 3.1-rc1 of drivers/usb/host/ehci-mxc.c
Message-ID: <CAMPhdO_yMC5w43A9xC7AsKO2razX1d2VVPtMp5Pm=wb6eFUYRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

Found the error below when trying to build 3.1-rc1 for imx51/53:

In file included from
/home/ycmiao/linaro/linux-2.6/drivers/usb/host/ehci-hcd.c:1190:0:
/home/ycmiao/linaro/linux-2.6/drivers/usb/host/ehci-mxc.c: In function
?ehci_mxc_drv_probe?:
/home/ycmiao/linaro/linux-2.6/drivers/usb/host/ehci-mxc.c:175:2:
error: implicit declaration of function ?cpu_is_mx35?
/home/ycmiao/linaro/linux-2.6/drivers/usb/host/ehci-mxc.c:175:2:
error: implicit declaration of function ?cpu_is_mx25?
/home/ycmiao/linaro/linux-2.6/drivers/usb/host/ehci-mxc.c:185:2:
error: implicit declaration of function ?cpu_is_mx51?
make[4]: *** [drivers/usb/host/ehci-hcd.o] Error 1
make[3]: *** [drivers/usb/host] Error 2
make[2]: *** [drivers/usb] Error 2
make[1]: *** [drivers] Error 2
make[1]: *** Waiting for unfinished jobs....
