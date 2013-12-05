From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 4 Dec 2013 16:55:33 -0800
Subject: [PATCH v6 11/17] USB: fsl-mph-dr-of: adjust for OF based clock
 lookup
In-Reply-To: <1385851897-23475-12-git-send-email-gsi@denx.de>
References: <1385851897-23475-1-git-send-email-gsi@denx.de>
 <1385851897-23475-12-git-send-email-gsi@denx.de>
Message-ID: <20131205005533.GB21377@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 30, 2013 at 11:51:31PM +0100, Gerhard Sittig wrote:
> after device tree based clock lookup became available, the peripheral
> driver need no longer construct clock names which include the component
> index -- remove the "usb%d_clk" template, always use "ipg" instead
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-usb at vger.kernel.org
> Signed-off-by: Gerhard Sittig <gsi@denx.de>
> ---

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
