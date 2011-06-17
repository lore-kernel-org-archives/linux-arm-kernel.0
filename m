From: ratheendran.s@gmail.com (Ravi)
Date: Fri, 17 Jun 2011 05:03:47 +0000 (UTC)
Subject: not able to use the datacard USB modem with ARM9 baord
Message-ID: <loom.20110617T064318-516@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear All,

I am using a ARM9 based mini2440 board.

I am trying to use the Data card(Reliance netconnect USB based modem) for
internet access.when I connect to PC this modem is recognized and I am able to
communicate with the modem with AT commands.

now when I try using the same modem it is recognized as storage device and modem
part of driver is not activated.Please note I am using the same kernel version
on board and PC i.e linux version 2.6.32.

the configuration on kernel side are.
  *** USB Device Class drivers                                                 
<*>   USB Modem (CDC ACM) support   
 <*>   USB Serial Converter support  ---> 
      <*>   USB driver for GSM and CDMA modems 
      <*>   USB Qualcomm Serial modem  

I am appending the kernel message from kernel when data card is connected.
usb 1-1: new full speed USB device using s3c2410-ohci and address 2
usb 1-1: New USB device found, idVendor=19d2, idProduct=fff5
usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 1-1: Product: USB Storage
usb 1-1: Manufacturer: ZTE, Incorporated
usb 1-1: SerialNumber: 000000000002
usb 1-1: configuration #1 chosen from 1 choice
scsi0 : SCSI emulation for USB Mass Storage devices
scsi 0:0:0:0: CD-ROM            ZTE      USB Storage FFF1 2.31 PQ: 0 ANSI: 2
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.20



Kindly let me know the changes required to make the data card working with my
embedded board.

Thanks in Advance,
Ravi
