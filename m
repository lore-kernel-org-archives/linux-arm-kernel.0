From: w@1wt.eu (Willy Tarreau)
Date: Sat, 18 May 2013 21:52:23 +0200
Subject: [PATCH] arm: mvebu: enable the third USB interface on OpenBlocks
 AX3
In-Reply-To: <519634F9.7060700@free-electrons.com>
References: <1368720444-29357-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130517.111810.02327269.yamagata@plathome.co.jp>
 <519634F9.7060700@free-electrons.com>
Message-ID: <20130518195223.GG1936@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

On Fri, May 17, 2013 at 03:47:37PM +0200, Gregory CLEMENT wrote:
> I applied and tested on my OpenBlocks AX3 and get the 3rd USB
> interface detected. As I don't have any mini-PCIe card which use USB,
> I didn't tested it furthermore, but as Atsushi Yamagata managed to
> detect an USB device on this interface, we can be pretty confident
> with this patch:

I do have a mini-PCIe to PCIe+USB adapter [1]. I have plugged it
with a USB flash and it was correctly detected as well after I
applied the patch :

usb 3-1: new high-speed USB device number 2 using orion-ehci
usb 3-1: New USB device found, idVendor=0781, idProduct=5567
usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 3-1: Product: Cruzer Blade
usb 3-1: Manufacturer: SanDisk

Best regards,
Willy

[1] : http://www.hwtools.net/Adapter/PM2.html
