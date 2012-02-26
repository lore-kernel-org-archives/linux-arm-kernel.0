From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 26 Feb 2012 23:36:48 +0000
Subject: [PATCH 2/3] ARM: PXA27x: save/restore PWER on suspend/resume
In-Reply-To: <201202262320.27934.marek.vasut@gmail.com>
References: <1330264062-5750-1-git-send-email-anarsoul@gmail.com>
 <1330264062-5750-2-git-send-email-anarsoul@gmail.com>
 <20120226142703.GN22562@n2100.arm.linux.org.uk>
 <201202262320.27934.marek.vasut@gmail.com>
Message-ID: <20120226233648.GD4706@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 26, 2012 at 11:20:27PM +0100, Marek Vasut wrote:
> > On Sun, Feb 26, 2012 at 04:47:41PM +0300, Vasily Khoruzhick wrote:
> > > Bootloader can clobber PWER value, so save it state on suspend.
> > 
> > What boot loader is this,
> 
> U-Boot, patched, not mainline.
> 
> > and why is it being so idiotic?
> 
> Mainline doesn't touch PWER, so please be careful about your accusations.
> 
> > Why can't it
> > be fixed?
> 
> Yes, either by using mainline uboot (to rule out the bootloader problem), 
> finding bug in linux kernel or reading the CPU manual.

Was there supposed to be any useful information in your reply, or are
you just trying to be your usual antagonistic self?
