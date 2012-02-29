From: artem.bityutskiy@intel.com (Bityutskiy, Artem)
Date: Wed, 29 Feb 2012 12:00:24 +0000
Subject: [PATCH v6 0/2] patch set about the MXS-DMA
In-Reply-To: <4F4DE0E5.8070808@freescale.com>
References: <1329373053-19494-1-git-send-email-b32955@freescale.com>
 <4F4D9725.3090100@freescale.com>
 <1330502098.3545.78.camel@sauron.fi.intel.com>
 <4F4DE0E5.8070808@freescale.com>
Message-ID: <1330516974.3545.104.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-02-29 at 16:25 +0800, Huang Shijie wrote:
> Hi Artem:
> > On Wed, 2012-02-29 at 11:10 +0800, Huang Shijie wrote:
> >> Hi:
> >>
> >> ping.
> > Is this patch-set independent or requires something like gpma patches?
> >
> This patch set is independent, and it does not depend upon any other 
> patches.

Pushed both to l2-mtd.git tree, thanks. I am worried that it touches
other subsystems like dma, sound, and mmc and there are no acks for
those. Would be nice to get them somehow.

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120229/fea79fec/attachment.sig>
-------------- next part --------------
---------------------------------------------------------------------
Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki 
Business Identity Code: 0357606 - 4 
Domiciled in Helsinki 

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
