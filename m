From: olof@lixom.net (Olof Johansson)
Date: Wed, 4 Apr 2012 10:51:12 -0700
Subject: [PATCH 01/11] usb: ehci-tegra: Add vbus_gpio to platform data
In-Reply-To: <1333148404-17691-2-git-send-email-swarren@wwwdotorg.org>
References: <1333148404-17691-1-git-send-email-swarren@wwwdotorg.org>
 <1333148404-17691-2-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20120404175112.GA29919@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 30, 2012 at 04:59:54PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Add a vbus_gpio field to platform data. This mirrors the device tree
> property nvidia,vbus-gpio. This makes the VBUS GPIO handling identical
> between booting with board files and device tree; the driver always does
> it.
> 
> This removes the need for board files to request and initialize the GPIO
> early during their boot process, perhaps even before the GPIO driver is
> ready to process the request.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: linux-usb at vger.kernel.org
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Acked-by: Olof Johansson <olof@lixom.net>

-Olof
