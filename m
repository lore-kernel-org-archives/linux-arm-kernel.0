From: rpkamiak@rockwellcollins.com (rpkamiak at rockwellcollins.com)
Date: Fri, 2 Jul 2010 11:59:42 -0700
Subject: Removing Spin Locks in ARM MXC GPIOs
Message-ID: <OF8F24F18F.F4C191D8-ON88257754.006829B2-88257754.006857CC@rockwellcollins.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'll make this quick.
Should the GPIO functions in gpio.c (i.e. mxc_gpio_set) perform a 
spin_lock prior to performing a read modify write operation on GPIO 
registers ?  They were removed somewhere between 2.6.22(imx31pdk-rel5) and 
2.6.31(imx35pdk-rel8). 

Thanks
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100702/c1c02842/attachment.html>
