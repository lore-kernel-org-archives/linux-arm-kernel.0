From: gregkh@linuxfoundation.org (Greg KH)
Date: Wed, 24 Oct 2012 14:27:32 -0700
Subject: [PATCH v6] Enable USB peripheral mode on dm365 EVM
In-Reply-To: <1349872412-22040-1-git-send-email-const@MakeLinux.com>
References: <1349872412-22040-1-git-send-email-const@MakeLinux.com>
Message-ID: <20121024212732.GA31406@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 10, 2012 at 02:33:32PM +0200, Constantine Shulyupin wrote:
> From: Constantine Shulyupin <const@MakeLinux.com>
> 
> Sets USB PHY clock source to 24 MHz clock and call USB configuration from board initialization.
> 
> Tested with OTG configuration, usb gadget g_zero on DM365 EVM connected to PC.
> 
> References:
> 
> Definition of USB_PHY_CTRL and PHYCLKFREQ:
> - http://www.makelinux.com/lib/ti/DM36x_ARM/doc-141
> 
> Original patch by miguel.aguilar at ridgerun.com three years ago:
> - http://www.mail-archive.com/davinci-linux-open-source at linux.davincidsp.com/msg14741.html
> 
> Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>

Note, Felipe is the right person to be sending these types of patches
to, not me.  scripts/get_maintainer.pl is your friend :)

thanks,

greg k-h
