From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 21 Jul 2014 15:22:05 +0200
Subject: [RESEND PATCH v3 06/11] drm: add DT bindings documentation for
 atmel-hlcdc-dc driver
In-Reply-To: <20140721125522.GE15238@ulmo>
References: <1404751384-5077-1-git-send-email-boris.brezillon@free-electrons.com>
 <20140721143428.078b68a4@bbrezillon> <20140721125522.GE15238@ulmo>
Message-ID: <2695740.osZpCPIB8S@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thierry,

On Monday 21 July 2014 14:55:23 Thierry Reding wrote:
> On Mon, Jul 21, 2014 at 02:34:28PM +0200, Boris BREZILLON wrote:
> > On Mon, 21 Jul 2014 14:16:42 +0200 Laurent Pinchart wrote:
> >> On Monday 21 July 2014 14:12:47 Thierry Reding wrote:
> >>> On Mon, Jul 21, 2014 at 11:57:37AM +0200, Boris BREZILLON wrote:

[snip]

> >>>> The new drm_display_info structure should look like this [2] (except
> >>>> that color_formats and bpc have not be removed yet), and [1] is just
> >>>> here to show how the video_bus_format enum would look like.
> >>>> 
> >>>> [1] http://code.bulix.org/rfd0yx-86557
> >>>> [2] http://code.bulix.org/7n03b4-86556
> >>> 
> >>> Quoting from your paste:
> >>> 	+   const enum video_bus_format *bus_formats;
> >>> 	+   int nbus_formats;
> >>> 
> >>> Do we really need more than one?
> >> 
> >> We do if we want to replace the color_formats and bpc fields.
> > 
> > Yes, that's what I was about to answer :-).
> 
> Maybe we don't need to replace color_formats and bpc field immediately.
> That could be done in a follow-up patch.

We don't need to replace them right now, but we should at least agree on how 
to replace them. Introducing a new field that would need to be replaced in the 
near future when removing color_formats and bpc would be a waste of time.

-- 
Regards,

Laurent Pinchart
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140721/72642444/attachment.sig>
