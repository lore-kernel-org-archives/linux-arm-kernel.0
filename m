From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Wed, 8 Jul 2015 10:55:26 +0300
Subject: [PATCH 1/5] usb: gadget: ffs: call functionfs_unbind() if
 _ffs_func_bind() fails
In-Reply-To: <559BF79B.903@hackerion.com>
References: <1436277773-14274-1-git-send-email-r.baldyga@samsung.com>
 <1436277773-14274-2-git-send-email-r.baldyga@samsung.com>
 <20150707145345.GD4341@mwanda> <559BF79B.903@hackerion.com>
Message-ID: <20150708075526.GK4341@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 07, 2015 at 06:00:27PM +0200, Robert Baldyga wrote:
> Decrement is done in ffs_func_unbind() which is not called in this
> error path.

Oh.  Duh.  I got functionfs_unbind() and ffs_func_unbind() mixed up.
Sorry.

regards,
dan carpenter
