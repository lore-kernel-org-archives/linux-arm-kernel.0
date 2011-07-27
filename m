From: manjugk@ti.com (G, Manjunath Kondaiah)
Date: Wed, 27 Jul 2011 19:34:57 +0530
Subject: [RFC/PATCH 0/7] decouple platform_device from omap_device
In-Reply-To: <1311292338-11830-1-git-send-email-khilman@ti.com>
References: <1311292338-11830-1-git-send-email-khilman@ti.com>
Message-ID: <20110727140457.GA8558@manju-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin,

On Thu, Jul 21, 2011 at 04:52:10PM -0700, Kevin Hilman wrote:
> Here's a first whack, proof-of-concept on how we could start to
> decouple the platform_device from an omap_device.
> 
> The main RFC is in the last patch, and everything leading up to it are
> misc. omap_device cleanups that make the last patch cleaner and
> clearer.  It's really the last patch that does the decoupling.
> 
> This will be necessary if we're going to decouple the platform_device
> creation from the omap_device/omap_hwmod creation etc.  This patch
> leaves them both done in omap_device_build(), but shows that they can
> be decoupled.
Can you pls mention baseline used for these patches? I tried applying on
latest mainline, v3.0 and  git://git.pwsan.com/linux-2.6 prcm-devel-3.1

It will not apply cleanly.

-M
