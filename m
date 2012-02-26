From: marek.vasut@gmail.com (Marek Vasut)
Date: Sun, 26 Feb 2012 23:20:27 +0100
Subject: [PATCH 2/3] ARM: PXA27x: save/restore PWER on suspend/resume
In-Reply-To: <20120226142703.GN22562@n2100.arm.linux.org.uk>
References: <1330264062-5750-1-git-send-email-anarsoul@gmail.com>
 <1330264062-5750-2-git-send-email-anarsoul@gmail.com>
 <20120226142703.GN22562@n2100.arm.linux.org.uk>
Message-ID: <201202262320.27934.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Sun, Feb 26, 2012 at 04:47:41PM +0300, Vasily Khoruzhick wrote:
> > Bootloader can clobber PWER value, so save it state on suspend.
> 
> What boot loader is this,

U-Boot, patched, not mainline.

> and why is it being so idiotic?

Mainline doesn't touch PWER, so please be careful about your accusations.

> Why can't it
> be fixed?

Yes, either by using mainline uboot (to rule out the bootloader problem), 
finding bug in linux kernel or reading the CPU manual.

M

PS. Vasily, keep me in Cc next time.
