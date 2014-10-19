From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 19 Oct 2014 11:01:07 +0200
Subject: USB Ethernet gadget on Nokia n900
Message-ID: <20141019090107.GA19132@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

>From 3.6 to 3.10, USB networking works on Nokia N900. With 3.11, it
fails with messages on the host. I also tried to get it to work on
3.14 and 3.17, with no luck.

Any ideas? Does it work for you? Any config options to watch for?

Best regards,
									Pavel 

Oct 19 10:10:52 amd kernel: [71388.656037] usb 4-1: new high-speed USB
device number 98 using ehci-pci
Oct 19 10:10:52 amd kernel: [71388.789842] usb 4-1: New USB device
found, idVendor=0525, idProduct=a4a2
Oct 19 10:10:52 amd kernel: [71388.789847] usb 4-1: New USB device
strings: Mfr=1, Product=2, SerialNumber=0
Oct 19 10:10:52 amd kernel: [71388.789851] usb 4-1: Product:
RNDIS/Ethernet Gadget
Oct 19 10:10:52 amd kernel: [71388.789854] usb 4-1: Manufacturer:
Linux 3.11.0-00115-g1b8e8c5-dirty with musb-hdrc
Oct 19 10:11:02 amd kernel: [71398.788300] cdc_subset: probe of
4-1:1.0 failed with error -22
Oct 19 10:11:05 amd systemd-udevd[167]: Network interface NamePolicy=
disabled on kernel commandline, ignoring.
Oct 19 10:11:07 amd kernel: [71403.788240] cdc_ether: probe of 4-1:1.0
failed with error -110
Oct 19 10:11:10 amd systemd-udevd[167]: Network interface NamePolicy=
disabled on kernel commandline, ignoring.
Oct 19 10:11:12 amd kernel: [71408.788237] cdc_subset: probe of
4-1:1.1 failed with error -110


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
