From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Sat, 9 Nov 2013 08:10:59 -0800
Subject: [PATCH 10/12] usb: r8a66597-hcd: Convert to clk_prepare/unprepare
In-Reply-To: <4726188.sxDyZ3Q5gt@avalon>
References: <1383000569-8916-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383000569-8916-11-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <526F842E.1010607@renesas.com> <4726188.sxDyZ3Q5gt@avalon>
Message-ID: <20131109161059.GB22695@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 09, 2013 at 03:12:05PM +0100, Laurent Pinchart wrote:
> Hi Greg,
> 
> On Tuesday 29 October 2013 18:47:26 Shimoda, Yoshihiro wrote:
> > Hi Laurent-san,
> > 
> > (2013/10/29 7:49), Laurent Pinchart wrote:
> > > Turn clk_enable() and clk_disable() calls into clk_prepare_enable() and
> > > clk_disable_unprepare() to get ready for the migration to the common
> > > clock framework.
> > > 
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > Cc: linux-usb at vger.kernel.org
> > > Signed-off-by: Laurent Pinchart
> > > <laurent.pinchart+renesas@ideasonboard.com>
> > 
> > Thank you for the patch.
> > 
> > Acked-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> 
> Could you please pick this patch up ?

I'll pick things up after 3.13-rc1 is out, I can't do anything until
then.

thanks,

greg k-h
