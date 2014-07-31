From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 31 Jul 2014 12:46:49 +0200
Subject: [PATCH v4] devicetree: Add generic IOMMU device tree bindings
In-Reply-To: <20140731102351.GJ9809@8bytes.org>
References: <1404487757-18829-1-git-send-email-thierry.reding@gmail.com>
 <20140730152646.GC20162@leverpostej> <20140731083923.GA31218@ulmo>
 <20140731092241.GA21850@leverpostej> <20140731101807.GB7458@ulmo>
 <20140731102351.GJ9809@8bytes.org>
Message-ID: <20140731104648.GD7458@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 31, 2014 at 12:23:51PM +0200, Joerg Roedel wrote:
> On Thu, Jul 31, 2014 at 12:18:08PM +0200, Thierry Reding wrote:
> > It looks like this hasn't been applied yet, so I can send out a v5
> > shortly with the requested changes addressed.
> 
> Yes, please send a v5 with the requested changes and all Reviewed-bys
> and Acked-bys this got so far. I'll take it into my tree then if nobody
> else objects.

I just sent out v5, although I trimmed the Cc list a little since it was
growing somewhat long. But I've kept everyone that gave feedback on v4
as well as the lists.

For reference I've attached the diff since v4.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: v5.patch
Type: text/x-diff
Size: 2938 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140731/cc6db465/attachment.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140731/cc6db465/attachment.sig>
