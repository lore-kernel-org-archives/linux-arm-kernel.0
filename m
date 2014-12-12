From: gregkh@linuxfoundation.org (Greg KH)
Date: Fri, 12 Dec 2014 09:32:44 -0500
Subject: [PATCH 0/4] serial: fsl_lpuart: fix various DMA related issues
In-Reply-To: <677f2c62b6b6c1fe8e16cd38d5f20d47@agner.ch>
References: <1417134205-4400-1-git-send-email-stefan@agner.ch>
 <677f2c62b6b6c1fe8e16cd38d5f20d47@agner.ch>
Message-ID: <20141212143244.GA2219@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 12, 2014 at 02:44:06PM +0100, Stefan Agner wrote:
> Any thoughts on this patchset? Would have hopped that it makes it into
> 3.19 as those are mostly fixes.

"mostly"?

I'll get to these after 3.19-rc1 is out, but it really looks like these
will be for 3.20-rc1, unless you break them up into "bugfix only" type
patches.

thanks,

greg k-h
