From: nava.manne@xilinx.com (Nava kishore Manne)
Date: Mon, 26 Sep 2016 12:49:49 +0000
Subject: [PATCH v4] devicetree: bindings: uart: Add new compatible
 string for ZynqMP
In-Reply-To: <20160923223747.GA1163@rob-hp-laptop>
References: <1474629948-9780-1-git-send-email-navam@xilinx.com>
 <20160923223747.GA1163@rob-hp-laptop>
Message-ID: <C89496FEAE474D468F30D558A9468D9F26D192EF@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Rob Herring [mailto:robh at kernel.org]
> Sent: Saturday, September 24, 2016 4:08 AM
> To: Nava kishore Manne <navam@xilinx.com>
> Cc: gregkh at linuxfoundation.org; mark.rutland at arm.com; jslaby at suse.com;
> michal.simek at xilinx.com; Soren Brinkmann <sorenb@xilinx.com>; linux-
> serial at vger.kernel.org; devicetree at vger.kernel.org; linux-
> kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; Punnaiah
> Choudary Kalluri <punnaia@xilinx.com>; Nava kishore Manne
> <navam@xilinx.com>
> Subject: Re: [PATCH v4] devicetree: bindings: uart: Add new compatible
> string for ZynqMP
>
> On Fri, Sep 23, 2016 at 04:55:48PM +0530, Nava kishore Manne wrote:
> > From: Nava kishore Manne <nava.manne@xilinx.com>
> >
> > This patch Adds the new compatible string for ZynqMP.
> >
> > Signed-off-by: Nava kishore Manne <navam@xilinx.com>
> > ---
> > Changes for v4:
> >             -Modified the ChangeLog comment.
> > Changes for v3:
> >             -Added changeLog comment.
> > Changes for v2:
> >                 -None
> >
> >  Documentation/devicetree/bindings/serial/cdns,uart.txt | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/serial/cdns,uart.txt
> b/Documentation/devicetree/bindings/serial/cdns,uart.txt
> > index a3eb154..4fe7aae 100644
> > --- a/Documentation/devicetree/bindings/serial/cdns,uart.txt
> > +++ b/Documentation/devicetree/bindings/serial/cdns,uart.txt
> > @@ -1,7 +1,8 @@
> >  Binding for Cadence UART Controller
> >
> >  Required properties:
> > -- compatible : should be "cdns,uart-r1p8", or "xlnx,xuartps"
> > +- compatible : should be "cdns,uart-r1p8", or "xlnx,xuartps" for Zynq and
> > +               "cdns,uart-r1p12" for Zynq Ultrascale+ MPSoC uart controller.
>
> Please format this as one valid combination per line.
>
> xuartps is not very specific. It needs some abbreviation of "Zynq
> Ultrascale+ MPSoC" in it.
>

Will fix the above comments in the next version.

Regards,
Navakishore.


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
