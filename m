From: balbi@ti.com (Felipe Balbi)
Date: Mon, 25 Nov 2013 20:12:39 -0600
Subject: [PATCH 09/12] usb: gadget: r8a66597-udc: Convert to
 clk_prepare/unprepare
In-Reply-To: <2503238.g4sCZxTpb5@avalon>
References: <1383000569-8916-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1930202.N3RGv6418i@avalon> <20131111195330.GE19212@saruman.home>
 <2503238.g4sCZxTpb5@avalon>
Message-ID: <20131126021239.GA22213@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Nov 26, 2013 at 02:59:51AM +0100, Laurent Pinchart wrote:
> > > > (2013/10/29 7:49), Laurent Pinchart wrote:
> > > > > Turn clk_enable() and clk_disable() calls into clk_prepare_enable()
> > > > > and clk_disable_unprepare() to get ready for the migration to the
> > > > > common clock framework.
> > > > > 
> > > > > Cc: Felipe Balbi <balbi@ti.com>
> > > > > Cc: linux-usb at vger.kernel.org
> > > > > Signed-off-by: Laurent Pinchart
> > > > > <laurent.pinchart+renesas@ideasonboard.com>
> > > > 
> > > > Thank you for the patch.
> > > > 
> > > > Acked-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > 
> > > Could you please pick this patch up ?
> > 
> > after -rc1 is out, I don't see why not.
> 
> Great then :-)
> 
> As this patch is a dependency for other series that will go through
> different trees, could you please provide a stable branch in your tree
> with this patch included that you will push to v3.14 ?

You guys are always killing me with those "stable branch" requests :-)

I'll get one up tomorrow. I guess I can avoid a topic branch altogether
if I just make this the first patch in "next" branch. I could push only
$subject for now until you merge then I'll push other stuff. Is that
enough for you ? My 'next' is always immutable.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131125/c950acae/attachment.sig>
