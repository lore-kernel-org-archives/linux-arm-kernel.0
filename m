From: vladoman@gmail.com (Vladimir Pantelic)
Date: Tue, 17 Jun 2014 15:45:59 +0200
Subject: Unifying cape overlays into boot .dtb for BeagleBoard.org boards
In-Reply-To: <20140617090931.GB3705@n2100.arm.linux.org.uk>
References: <CA+T6QP==raXdWz9mezK3JxSvZjWhUZZ7aKv4CpCr0SbdaCMgDQ@mail.gmail.com>
 <CA+T6QPmCk9GzHPHqCKG4vHDvUGirgGaizH-V9bsHT4V=8=gCaA@mail.gmail.com>
 <20140617090931.GB3705@n2100.arm.linux.org.uk>
Message-ID: <53A04697.1020904@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/17/2014 11:09 AM, Russell King - ARM Linux wrote:

> Here's the most obvious question in the world on this topic.  Are capes
> hot-pluggable?

"capes" as in Beaglebone capes might not be due to the mechanical 
constraints you listed.

"capes" as a concept of pluggable hardware might well be. here is a real 
world example of commercially available pluggable hardware add-ons on a 
Linux system back from 2008:

http://en.wikipedia.org/wiki/Archos_Generation_6#Accessories

depending on the add-on, different interfaces like GPIO, UART, USB, SPI 
using the same pins were used and there was no reboot needed to load a 
new hardware configuration or change the pinmux
