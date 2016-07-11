From: tiffany.lin@mediatek.com (tiffany lin)
Date: Mon, 11 Jul 2016 10:56:11 +0800
Subject: [PATCH v3 3/9] DocBook/v4l: Add compressed video formats used
 on MT8173 codec driver
In-Reply-To: <5a793171-24a7-4e9e-8bfd-f668c789f8e0@xs4all.nl>
References: <1464611363-14936-1-git-send-email-tiffany.lin@mediatek.com>
 <1464611363-14936-2-git-send-email-tiffany.lin@mediatek.com>
 <1464611363-14936-3-git-send-email-tiffany.lin@mediatek.com>
 <1464611363-14936-4-git-send-email-tiffany.lin@mediatek.com>
 <5a793171-24a7-4e9e-8bfd-f668c789f8e0@xs4all.nl>
Message-ID: <1468205771.3725.8.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

On Fri, 2016-07-08 at 12:23 +0200, Hans Verkuil wrote:
> On 05/30/2016 02:29 PM, Tiffany Lin wrote:
> > Add V4L2_PIX_FMT_MT21 documentation
> > 
> > Signed-off-by: Tiffany Lin <tiffany.lin@mediatek.com>
> > ---
> >  Documentation/DocBook/media/v4l/pixfmt.xml |    6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/Documentation/DocBook/media/v4l/pixfmt.xml b/Documentation/DocBook/media/v4l/pixfmt.xml
> > index 5a08aee..d40e0ce 100644
> > --- a/Documentation/DocBook/media/v4l/pixfmt.xml
> > +++ b/Documentation/DocBook/media/v4l/pixfmt.xml
> > @@ -1980,6 +1980,12 @@ array. Anything what's in between the UYVY lines is JPEG data and should be
> >  concatenated to form the JPEG stream. </para>
> >  </entry>
> >  	  </row>
> > +	  <row id="V4L2_PIX_FMT_MT21">
> > +	    <entry><constant>V4L2_PIX_FMT_MT21</constant></entry>
> > +	    <entry>'MT21'</entry>
> > +	    <entry>Compressed two-planar YVU420 format used by Mediatek MT8173
> > +	    codec driver.</entry>
> 
> Can you give a few more details? The encoder driver doesn't seem to produce this
> format, so who is creating this? Where is this format documented?
> 

It can be as input format for encoder, MDP and display drivers in our
platform.
This private format is only available in our platform.
So I put it in "Reserved Format Identifiers" sections.


best regards,
Tiffany

> Regards,
> 
> 	Hans
> 
> > +	  </row>
> >  	</tbody>
> >        </tgroup>
> >      </table>
> > 
