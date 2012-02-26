From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 26 Feb 2012 14:27:03 +0000
Subject: [PATCH 2/3] ARM: PXA27x: save/restore PWER on suspend/resume
In-Reply-To: <1330264062-5750-2-git-send-email-anarsoul@gmail.com>
References: <1330264062-5750-1-git-send-email-anarsoul@gmail.com>
 <1330264062-5750-2-git-send-email-anarsoul@gmail.com>
Message-ID: <20120226142703.GN22562@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 26, 2012 at 04:47:41PM +0300, Vasily Khoruzhick wrote:
> Bootloader can clobber PWER value, so save it state on suspend.

What boot loader is this, and why is it being so idiotic?  Why can't it
be fixed?
