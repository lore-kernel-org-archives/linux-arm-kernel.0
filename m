From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Wed, 20 Apr 2016 11:30:10 +0000
Subject: [PATCH 1/2] Documentation: DT: vdma: Add clock support for vdma
In-Reply-To: <571764CF.6070003@metafoo.de>
References: <1461136800-20334-1-git-send-email-appanad@xilinx.com>
 <CAKfKVtEkfnDqU476troXmCw20ATvQvj-JdPX-BCuPDR-9ZxKHQ@mail.gmail.com>
 <C246CAC1457055469EF09E3A7AC4E11A4A578F73@XAP-PVEXMBX01.xlnx.xilinx.com>
 <571764CF.6070003@metafoo.de>
Message-ID: <C246CAC1457055469EF09E3A7AC4E11A4A5791F3@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lars,

> -----Original Message-----
> From: Lars-Peter Clausen [mailto:lars at metafoo.de]
> Sent: Wednesday, April 20, 2016 4:45 PM
> To: Appana Durga Kedareswara Rao <appanad@xilinx.com>; Shubhrajyoti Datta
> <shubhrajyoti.datta@gmail.com>
> Cc: Rob Herring <robh+dt@kernel.org>; Pawel Moll <pawel.moll@arm.com>;
> Mark Rutland <mark.rutland@arm.com>; Ian Campbell
> <ijc+devicetree@hellion.org.uk>; Kumar Gala <galak@codeaurora.org>; Michal
> Simek <michals@xilinx.com>; Soren Brinkmann <sorenb@xilinx.com>;
> vinod.koul at intel.com; dan.j.williams at intel.com; Moritz Fischer
> <moritz.fischer@ettus.com>; Laurent Pinchart
> <laurent.pinchart@ideasonboard.com>; luis at debethencourt.com; Anirudha
> Sarangi <anirudh@xilinx.com>; Punnaiah Choudary Kalluri
> <punnaia@xilinx.com>; dmaengine at vger.kernel.org;
> devicetree at vger.kernel.org; linux-kernel at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH 1/2] Documentation: DT: vdma: Add clock support for vdma
> 
> On 04/20/2016 10:39 AM, Appana Durga Kedareswara Rao wrote:
> [...]
> >> however  we should keep the names same as the TRM.
> >
> > Why?? Why can't we use simple convenient names that refers to
> > equivalent clocks of h/w
> 
> Because it is confusing. If you use the same name it's very straight forward to
> understand which clock is being referred to. That's not the case if you come up
> with random new names.

Ok will fix in the v2...

Regards,
Kedar.
