From: balbi@ti.com (Felipe Balbi)
Date: Mon, 11 Nov 2013 13:53:31 -0600
Subject: [PATCH 09/12] usb: gadget: r8a66597-udc: Convert to
 clk_prepare/unprepare
In-Reply-To: <1930202.N3RGv6418i@avalon>
References: <1383000569-8916-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383000569-8916-10-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <526F8427.8000209@renesas.com> <1930202.N3RGv6418i@avalon>
Message-ID: <20131111195330.GE19212@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 09, 2013 at 03:09:33PM +0100, Laurent Pinchart wrote:
> Hi Felipe,
> 
> On Tuesday 29 October 2013 18:47:19 Shimoda, Yoshihiro wrote:
> > Hi Laurent-san,
> > 
> > (2013/10/29 7:49), Laurent Pinchart wrote:
> > > Turn clk_enable() and clk_disable() calls into clk_prepare_enable() and
> > > clk_disable_unprepare() to get ready for the migration to the common
> > > clock framework.
> > > 
> > > Cc: Felipe Balbi <balbi@ti.com>
> > > Cc: linux-usb at vger.kernel.org
> > > Signed-off-by: Laurent Pinchart
> > > <laurent.pinchart+renesas@ideasonboard.com>
> > 
> > Thank you for the patch.
> > 
> > Acked-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> 
> Could you please pick this patch up ?

after -rc1 is out, I don't see why not.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131111/c35ede67/attachment-0001.sig>
