From: tremyfr@yahoo.fr (Philippe Reynes)
Date: Sun, 11 Nov 2012 20:34:34 +0000 (GMT)
Subject: usb clock not found on imx27 when using dt
Message-ID: <1352666074.32152.YahooMailNeo@web28806.mail.ir2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I try to add the support of usb on my armadeus apf27,
but there is a problem when try to reclaim the clock.
imx_usb mxc-ehci.0: Failed to get clock, err=-2

To avoid adding too many attachment to this mail,
I've put all the information on a website. You can
found them here:? http://ryu.zarb.org/~trem/armadeus/


The initial issue is in the directory : 20121110

boot-3.7-rc4.log : boot log with the issue
linux-3.7-rc4.config : the configuration file for the kernel
investifation.txt : the description of my investigation.


I've tried to fix the clock issue, but another issue occurs.
The information about this "fix" is in : 20121111
boot-3.7-rc4.log : boot log with the new issue
issue.txt : the description of the change done on the kernel

I've got severals questions :
- does my dts correct with usb change ?
- does someone has already tested usb on imx27 with dt ?

Regards,
Philippe
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121111/3bbd3fdc/attachment-0001.html>
