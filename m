From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sat, 12 Mar 2011 22:34:01 +0200
Subject: [PATCH 5/8] ARM: PXA: Z2: Add poweroff function
In-Reply-To: <201103121416.19327.marek.vasut@gmail.com>
References: <1299839023-16601-1-git-send-email-anarsoul@gmail.com>
	<201103121330.22949.anarsoul@gmail.com>
	<201103121416.19327.marek.vasut@gmail.com>
Message-ID: <201103122234.01568.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 12 March 2011 15:16:19 Marek Vasut wrote:
 
> Besides, this is nonsense, you're doing a hack and you're trying to justify
> it. You cannot powerdown the device, period. You should rather patch the
> bootloader to implement this para-powerdown behaviour than bloat kernel
> with this workaround.

And, btw, there's same code in mainline kernel for zeus machine.
