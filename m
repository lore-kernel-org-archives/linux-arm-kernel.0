From: R00091@freescale.com (Nguyen Dinh-R00091)
Date: Tue, 11 May 2010 20:44:42 -0700
Subject: [PATCHv2 2.6.34-rc7 2/3] mx5: change usb clock source from pll3
	to pll2
In-Reply-To: <20100511233221.GA31311@kroah.com>
References: <1273508519-23033-1-git-send-email-Dinh.Nguyen@freescale.com>
	<1273508519-23033-2-git-send-email-Dinh.Nguyen@freescale.com>
	<20100511233221.GA31311@kroah.com>
Message-ID: <86A0E76937111F4C92FABEC0A2098851048701E6@az33exm21>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 10, 2010 at 11:21:58AM -0500, Dinh Nguyen wrote:
> For power management reasons, pll2 should be used to source the USBOH3

> clock for mx51. PLL3 can be completely gated off when USB is not used.
> 
> This patch applies to 2.6.34-rc7.

On Tuesday, May 11, 2010 6:32 PM , Greg KH wroe:
> Hm, no, it seems to conflict and does not apply :(

>I've taken the first one, shouldn't the two others go through some arm
tree?

It looks like Sascha has taken the patch 2/3 and 3/3. Thanks, Dinh
