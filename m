From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sat, 12 Mar 2011 22:33:27 +0200
Subject: [PATCH 5/8] ARM: PXA: Z2: Add poweroff function
In-Reply-To: <201103121416.19327.marek.vasut@gmail.com>
References: <1299839023-16601-1-git-send-email-anarsoul@gmail.com>
	<201103121330.22949.anarsoul@gmail.com>
	<201103121416.19327.marek.vasut@gmail.com>
Message-ID: <201103122233.27282.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 12 March 2011 15:16:19 Marek Vasut wrote:
> 
> What about blob and other bootloaders. U-Boot isn't the only one running on
> that device, right ?

There's only blob binary for this device (with default firmware). I doubt 
anyone tried to build blob from sources with Aeronix' patches.
 
> Besides, this is nonsense, you're doing a hack and you're trying to justify
> it. You cannot powerdown the device, period. You should rather patch the
> bootloader to implement this para-powerdown behaviour than bloat kernel
> with this workaround.

I'm OK with this out of tree patch. I don't do bootloader hacking without 
ability to unbrick device.

Regards,
Vasily
