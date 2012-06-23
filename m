From: gregkh@linuxfoundation.org (Greg KH)
Date: Fri, 22 Jun 2012 21:44:45 -0700
Subject: [RFC PATCH v2 1/2] drivers: misc: omap: add a new driver for
 ocp2scp
In-Reply-To: <1340370942-23201-2-git-send-email-kishon@ti.com>
References: <1340370942-23201-1-git-send-email-kishon@ti.com>
 <1340370942-23201-2-git-send-email-kishon@ti.com>
Message-ID: <20120623044445.GA2993@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 22, 2012 at 06:45:41PM +0530, Kishon Vijay Abraham I wrote:
> Adds a new driver _ocp2scp_.

That's not what you called this driver in the patch below :(

> This driver takes the responsibility of creating
> all the devices that is connected to OCP2SCP. In the case of OMAP4, USB2PHY
> is connected to ocp2scp.
> 
> This also includes device tree support for ocp2scp driver and
> the documentation with device tree binding information is updated.

Can't this live where the scp drivers live?  Actually, where is that at?
Do we have scp drivers?

thanks,

greg k-h
