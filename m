From: greg@kroah.com (Greg KH)
Date: Fri, 9 Dec 2011 15:49:00 -0800
Subject: [PATCH 1/2] usb: at91: fix clk_get error handling
In-Reply-To: <1323358321-19918-1-git-send-email-plagnioj@jcrosoft.com>
References: <1323358321-19918-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <20111209234900.GA6680@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 08, 2011 at 04:32:00PM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: linux-usb at vger.kernel.org
> ---
> Hi,
> 
> 	can we apply via at91 as it's depend on patch already on arm-soc

That's fine with me, feel free to add:
	Acked-by: Greg Kroah-Hartman <gregkh@suse.de>

to both of these patches and take them through the arm-soc tree.

greg k-h
