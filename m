From: greg@kroah.com (Greg KH)
Date: Tue, 11 May 2010 16:32:21 -0700
Subject: [PATCHv2 2.6.34-rc7 2/3] mx5: change usb clock source from
	pll3 to pll2
In-Reply-To: <1273508519-23033-2-git-send-email-Dinh.Nguyen@freescale.com>
References: <1273508519-23033-1-git-send-email-Dinh.Nguyen@freescale.com>
	<1273508519-23033-2-git-send-email-Dinh.Nguyen@freescale.com>
Message-ID: <20100511233221.GA31311@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 10, 2010 at 11:21:58AM -0500, Dinh Nguyen wrote:
> For power management reasons, pll2 should be used to source the USBOH3
> clock for mx51. PLL3 can be completely gated off when USB is not used.
> 
> This patch applies to 2.6.34-rc7.

Hm, no, it seems to conflict and does not apply :(

I've taken the first one, shouldn't the two others go through some arm
tree?


thanks,

greg k-h
