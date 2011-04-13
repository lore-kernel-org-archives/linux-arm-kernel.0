From: greg@kroah.com (Greg KH)
Date: Wed, 13 Apr 2011 16:54:02 -0700
Subject: [PATCH 3/4] ARM: EXYNOS4: Add usb ehci device to the NURI board
In-Reply-To: <1302236532-27636-3-git-send-email-jy0922.shim@samsung.com>
References: <1302236532-27636-1-git-send-email-jy0922.shim@samsung.com>
	<1302236532-27636-3-git-send-email-jy0922.shim@samsung.com>
Message-ID: <20110413235402.GA32159@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 08, 2011 at 01:22:11PM +0900, Joonyoung Shim wrote:
> This patch is to support usb ehci device to the NURI board.
> 
> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Note, I had to apply this one by hand, I don't know what tree you made
it against.  Hopefully the merge issues will be simple to handle, as
they were pretty obvious to me.

thanks,

greg k-h
