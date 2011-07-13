From: paulo@nlink.com.br (Paulo Fragoso)
Date: Wed, 13 Jul 2011 15:27:43 -0300
Subject: AT91 SDIO WiFi no working
Message-ID: <4E1DE39F.3030104@nlink.com.br>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

We are trying to run SDIO WiFI with a board based on AT91sam9 and our 
configuration and firmware files are apparently ok but now we have got 
this erro:

root at buildroot:~# modprobe libertas
root at buildroot:~# modprobe libertas_sdio.ko 
helper_name=/lib/firmware/sd8686_v8_
helper.bin fw_name=/lib/firmware/sd8686_v8.bin
libertas_sdio: Libertas SDIO driver
libertas_sdio: Copyright Pierre Ossman
libertas: can't load helper firmware
libertas: failed to load helper firmware
libertas_sdio: probe of mmc0:0001:1 failed with error -2

udev is running too, what might be happening?

Thanks,
Paulo.

-- 
Digium-Certified Asterisk Professional (dCAP: 1947)
FreeBSD/UN*X Administrator
Electronic Engineer
+55 81 2121-6666 - www.nlink.com.br
Cel:81 9727-6666 - Voip:   786-7161
