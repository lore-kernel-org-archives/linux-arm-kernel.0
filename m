From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Tue, 12 Apr 2016 06:20:53 +0000
Subject: [PATCH v4 4/5] Documentation: DT: vdma: update binding doc for
 AXI CDMA
In-Reply-To: <20160411140243.GA827@rob-hp-laptop>
References: <1460006985-14805-1-git-send-email-appanad@xilinx.com>
 <1460006985-14805-5-git-send-email-appanad@xilinx.com>
 <20160411140243.GA827@rob-hp-laptop>
Message-ID: <C246CAC1457055469EF09E3A7AC4E11A4A57553D@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Rob Herring [mailto:robh at kernel.org]
> Sent: Monday, April 11, 2016 7:33 PM
> To: Appana Durga Kedareswara Rao <appanad@xilinx.com>
> Cc: pawel.moll at arm.com; mark.rutland at arm.com;
> ijc+devicetree at hellion.org.uk; galak at codeaurora.org; Michal Simek
> <michals@xilinx.com>; Soren Brinkmann <sorenb@xilinx.com>;
> vinod.koul at intel.com; dan.j.williams at intel.com; Appana Durga Kedareswara
> Rao <appanad@xilinx.com>; moritz.fischer at ettus.com;
> laurent.pinchart at ideasonboard.com; luis at debethencourt.com; Anirudha
> Sarangi <anirudh@xilinx.com>; devicetree at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> dmaengine at vger.kernel.org
> Subject: Re: [PATCH v4 4/5] Documentation: DT: vdma: update binding doc for
> AXI CDMA
> 
> On Thu, Apr 07, 2016 at 10:59:44AM +0530, Kedareswara rao Appana wrote:
> > This patch updates the device-tree binding doc for adding support for
> > AXI CDMA.
> >
> > Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
> > ---
> > Changes for v4:
> > ---> None.
> > Changes for v3:
> > ---> Removed CDMA DT example from the patch as suggested by the Rob.
> > Changes for v2:
> > ---> Modified commit message as suggested by Vinod.
> > ---> Moved the patch to forward in the series as suggested by vinod.
> >
> >  Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt | 6
> > +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> Acked-by: Rob Herring <robh@kernel.org>

Thanks for the Ack Rob...

@Vinod: I got the Ack's for the binding doc patches in this series
If you are ok with the other patches could you please apply this patch series? 

Regards,
Kedar.
