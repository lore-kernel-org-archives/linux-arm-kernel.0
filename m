From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Tue, 1 Mar 2011 18:07:01 +0100
Subject: resend hsudc patches for s3c24xx?
Message-ID: <201103011807.01828.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

some time around october 2010 Sangbeom Kim posted patches from Thomas Abraham 
to support the hs-udc of the s3c24xx-platform. But these patches were not 
added to the kernel.

We are currently working on s3c2416 based devices which would profit from this 
drivers and not having to keep them locally.

We ported the patches to a 2.6.38-rc state which can be found on [1] and also 
attached. Especially the driver itself [2] needed a bit of rework and I'm not 
sure if the gadget_chips id is simply incremented for new drivers.

As the merge-window for 2.6.39 approaches, could you have another look at them 
and merge eventually them into the linux-samsung tree?


Thanks
Heiko


[1] http://gitorious.org/oyo-hack/kernel/commits/s3c-hsudc
[2] http://gitorious.org/oyo-
hack/kernel/commit/c063317869d11c3b8f906061319f8a075de06b5c
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-ARM-S3C2416-Add-USB-Phy-register-definitions.patch
Type: text/x-patch
Size: 2146 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110301/11ab6ee5/attachment-0004.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002-ARM-S3C24XX-Add-plaform-device-definition-for-USB-Hi.patch
Type: text/x-patch
Size: 4593 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110301/11ab6ee5/attachment-0005.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0004-ARM-S3C2416-Add-support-for-USB-2.0-High-Speed-gadge.patch
Type: text/x-patch
Size: 2728 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110301/11ab6ee5/attachment-0006.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0003-USB-Gadget-Add-Samsung-S3C24XX-USB-High-Speed-contro.patch
Type: text/x-patch
Size: 40485 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110301/11ab6ee5/attachment-0007.bin>
