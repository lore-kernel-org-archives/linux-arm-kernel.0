From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 17 Sep 2012 04:18:05 -0700
Subject: [PATCH 17/34] usb: ehci-mxc: remove unneeded mach/hardware.h
 inclusion
In-Reply-To: <1347860103-4141-18-git-send-email-shawn.guo@linaro.org>
References: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
 <1347860103-4141-18-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120917111805.GB28340@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 17, 2012 at 01:34:46PM +0800, Shawn Guo wrote:
> The inclusion of mach/hardware.h is not used by the driver at all.
> Remove it.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-usb at vger.kernel.org

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
