From: greg@kroah.com (Greg KH)
Date: Thu, 12 Apr 2012 06:10:45 -0700
Subject: [PATCH v4 0/7] Add TI EMIF SDRAM controller driver
In-Reply-To: <4F867A95.9030104@ti.com>
References: <1331934707-29487-1-git-send-email-aneesh@ti.com>
 <alpine.DEB.2.00.1204112042070.29473@utopia.booyaka.com>
 <20120412030044.GA26236@kroah.com> <4F867A95.9030104@ti.com>
Message-ID: <20120412131045.GB31384@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 12, 2012 at 12:17:49PM +0530, Santosh Shilimkar wrote:
> I was hoping that we will have some thing like drivers/memory/*
> but since it doesn't exist, we used drivers/misc.

Why not create it?  I have no objection to that, it makes it more
obvious as to what this really is.

greg k-h
