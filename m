From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 13 Jun 2014 15:32:07 +0200
Subject: [PATCH V2] ARM: mvebu: DT: fix OpenBlocks AX3-4 RAM size
In-Reply-To: <1401889280-8528-1-git-send-email-jason@lakedaemon.net>
References: <5388ddb9.0458440a.2be7.323c@mx.google.com>
 <1401889280-8528-1-git-send-email-jason@lakedaemon.net>
Message-ID: <201406131532.08164.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 June 2014, Jason Cooper wrote:
> The OpenBlocks AX3-4 has a non-DT bootloader.  It also comes with 1GB of
> soldered on RAM, and a DIMM slot for expansion.
> 
> Unfortunately, atags_to_fdt() doesn't work in big-endian mode, so we see
> the following failure when attempting to boot a big-endian kernel:
> 

I've applied it to the fixes branch now, sorry for the delay.

	Arnd
