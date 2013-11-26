From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 26 Nov 2013 02:59:51 +0100
Subject: [PATCH 09/12] usb: gadget: r8a66597-udc: Convert to
 clk_prepare/unprepare
In-Reply-To: <20131111195330.GE19212@saruman.home>
References: <1383000569-8916-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1930202.N3RGv6418i@avalon> <20131111195330.GE19212@saruman.home>
Message-ID: <2503238.g4sCZxTpb5@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felipe,

On Monday 11 November 2013 13:53:31 Felipe Balbi wrote:
> On Sat, Nov 09, 2013 at 03:09:33PM +0100, Laurent Pinchart wrote:
> > Hi Felipe,
> > 
> > On Tuesday 29 October 2013 18:47:19 Shimoda, Yoshihiro wrote:
> > > Hi Laurent-san,
> > > 
> > > (2013/10/29 7:49), Laurent Pinchart wrote:
> > > > Turn clk_enable() and clk_disable() calls into clk_prepare_enable()
> > > > and clk_disable_unprepare() to get ready for the migration to the
> > > > common clock framework.
> > > > 
> > > > Cc: Felipe Balbi <balbi@ti.com>
> > > > Cc: linux-usb at vger.kernel.org
> > > > Signed-off-by: Laurent Pinchart
> > > > <laurent.pinchart+renesas@ideasonboard.com>
> > > 
> > > Thank you for the patch.
> > > 
> > > Acked-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > 
> > Could you please pick this patch up ?
> 
> after -rc1 is out, I don't see why not.

Great then :-)

As this patch is a dependency for other series that will go through different 
trees, could you please provide a stable branch in your tree with this patch 
included that you will push to v3.14 ?

-- 
Regards,

Laurent Pinchart
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 490 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131126/48349950/attachment.sig>
