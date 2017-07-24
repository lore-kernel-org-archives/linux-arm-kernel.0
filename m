From: smitha.t@samsung.com (Smitha T Murthy)
Date: Mon, 24 Jul 2017 09:58:45 +0530
Subject: [Patch v5 06/12] [media] v4l2-ioctl: add HEVC format description
In-Reply-To: <e6e75cae-f195-af56-652e-37c3e51ad70f@xs4all.nl>
References: <1497849055-26583-1-git-send-email-smitha.t@samsung.com>
 <CGME20170619052507epcas1p406fa9f6d84baa9c11050b1998021788a@epcas1p4.samsung.com>
 <1497849055-26583-7-git-send-email-smitha.t@samsung.com>
 <e6e75cae-f195-af56-652e-37c3e51ad70f@xs4all.nl>
Message-ID: <1500870525.16819.1817.camel@smitha-fedora>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-07-20 at 15:07 +0200, Hans Verkuil wrote:
> On 19/06/17 07:10, Smitha T Murthy wrote:
> > HEVC is a video coding format
> > 
> > Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
> > ---
> >  drivers/media/v4l2-core/v4l2-ioctl.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> > index e5a2187..4f6f8d9 100644
> > --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> > +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> > @@ -1257,6 +1257,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
> >  		case V4L2_PIX_FMT_VC1_ANNEX_L:	descr = "VC-1 (SMPTE 412M Annex L)"; break;
> >  		case V4L2_PIX_FMT_VP8:		descr = "VP8"; break;
> >  		case V4L2_PIX_FMT_VP9:		descr = "VP9"; break;
> > +		case V4L2_PIX_FMT_HEVC:		descr = "HEVC"; break;
> 
> Add a little comment at the end of the line: /* aka H.265 */
> 
> After that you can add my:
> 
> Acked-by: Hans Verkuil <hans.verkuil@cisco.com>
> 
> Regards,
> 
> 	Hans
> 
Ok I will make the change. Thanks for the review.

Regards,
Smitha

> >  		case V4L2_PIX_FMT_CPIA1:	descr = "GSPCA CPiA YUV"; break;
> >  		case V4L2_PIX_FMT_WNVA:		descr = "WNVA"; break;
> >  		case V4L2_PIX_FMT_SN9C10X:	descr = "GSPCA SN9C10X"; break;
> > 
> 
> 
> 
