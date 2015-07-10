From: balbi@ti.com (Felipe Balbi)
Date: Fri, 10 Jul 2015 12:27:01 -0500
Subject: [PATCH 2/3] i2c: omap: abolish variable name confusion
In-Reply-To: <20150709194941.GH4744@katana>
References: <1435260890-32335-1-git-send-email-balbi@ti.com>
 <1435260890-32335-2-git-send-email-balbi@ti.com>
 <20150709194941.GH4744@katana>
Message-ID: <20150710172701.GB20408@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jul 09, 2015 at 09:49:41PM +0200, Wolfram Sang wrote:
> On Thu, Jun 25, 2015 at 02:34:49PM -0500, Felipe Balbi wrote:
> > struct device pointers are usually called
> > dev. Calling our struct omap_i2c_dev pointers
> > also dev has caused enough confusion.
> > 
> > This is the result of a few simple sed rules
> > to convert all struct omap_i2c_dev pointers
> > to be called omap instead.
> > 
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> 
> I couldn't apply this one. On what was it based?

it was v4.1 at the time, IIRC. I'll rebase again once I'm back in the
office.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150710/e7a09c43/attachment.sig>
