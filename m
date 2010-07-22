From: sudheesh@diganttechnologies.com (sudheesh)
Date: 22 Jul 2010 07:11:01 -0000
Subject: =?utf-8?B?YXQ5MXNhbTlnNDUgY3VzdG9tIGJvYXJkIGJvb3RpbmcgcHJvYmxlbQ==?=
Message-ID: <20100722071101.42173.qmail@pro237-185.mxout.rediffmailpro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; we&nbsp; are making a custom board same as at9sam9g45ek. i have cross compiled u-boot linux kernel bootstrap and made root filesystem (x11) as per the direction from http://www.at91.com/linux4sam/bin/view/Linux4SAM/ site.The problem is not booting system at all the times.I am attaching the boot message from debug port.We used atmel atsam9g45 default configuration to make linux kernel image with CONFIG_USB_HID=y to support usb mouse and key board and minor change in linux-2.6.30/arch/arm/mach-at91/board-sam9m10g45ek.c to support vga display proper and a minor change in /etc/X11/Xserver to support usb mouse .Please guide me to debug step by step.

regards
sudheesh
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100722/ca8f9598/attachment-0001.html>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: data.tar.gz
Type: application/x-gzip
Size: 108139 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100722/ca8f9598/attachment-0001.gz>
