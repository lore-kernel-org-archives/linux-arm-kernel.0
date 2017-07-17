From: smitha.t@samsung.com (Smitha T Murthy)
Date: Mon, 17 Jul 2017 16:42:39 +0530
Subject: [Patch v5 05/12] [media] videodev2.h: Add v4l2 definition for HEVC
In-Reply-To: <12b890e0-b955-4d64-6b6b-2847f693ee57@linaro.org>
References: <1497849055-26583-1-git-send-email-smitha.t@samsung.com>
 <CGME20170619052505epcas5p33a78ee709263cc9ae33cd9383794ca06@epcas5p3.samsung.com>
 <1497849055-26583-6-git-send-email-smitha.t@samsung.com>
 <12b890e0-b955-4d64-6b6b-2847f693ee57@linaro.org>
Message-ID: <1500289959.16819.0.camel@smitha-fedora>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-07-07 at 17:56 +0300, Stanimir Varbanov wrote:
> Hi Smitha,
> 
> On 06/19/2017 08:10 AM, Smitha T Murthy wrote:
> > Add V4L2 definition for HEVC compressed format
> > 
> > Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
> > Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> > ---
> >  include/uapi/linux/videodev2.h | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> > index 2b8feb8..488de3d 100644
> > --- a/include/uapi/linux/videodev2.h
> > +++ b/include/uapi/linux/videodev2.h
> > @@ -629,6 +629,7 @@ struct v4l2_pix_format {
> >  #define V4L2_PIX_FMT_VC1_ANNEX_L v4l2_fourcc('V', 'C', '1', 'L') /* SMPTE 421M Annex L compliant stream */
> >  #define V4L2_PIX_FMT_VP8      v4l2_fourcc('V', 'P', '8', '0') /* VP8 */
> >  #define V4L2_PIX_FMT_VP9      v4l2_fourcc('V', 'P', '9', '0') /* VP9 */
> > +#define V4L2_PIX_FMT_HEVC     v4l2_fourcc('H', 'E', 'V', 'C') /* HEVC */
> >  
> >  /*  Vendor-specific formats   */
> >  #define V4L2_PIX_FMT_CPIA1    v4l2_fourcc('C', 'P', 'I', 'A') /* cpia1 YUV */
> > 
> 
> Hans wanted the name to be H265, not sure is that valid yet.
> 
> I have tested 5/12, 6/12, and 7/12 on venus codec driver, and in case
> you need it, you have my
> 
> Reviewed-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> 
Thank you for the review.

Regards,
Smitha
