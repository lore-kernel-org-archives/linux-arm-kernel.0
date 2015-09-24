From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Thu, 24 Sep 2015 12:19:33 +0000
Subject: [PATCH v6 1/2] dmaengine: Add Xilinx Central DMA DT Binding
 Documentation
In-Reply-To: <1986807.ieBkZICvCQ@wuerfel>
References: <1441629188-17601-1-git-send-email-appanad@xilinx.com>
 <1986807.ieBkZICvCQ@wuerfel>
Message-ID: <C246CAC1457055469EF09E3A7AC4E11A4A4E7DD4@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,
	
> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: Monday, September 07, 2015 6:26 PM
> To: Appana Durga Kedareswara Rao
> Cc: robh+dt at kernel.org; vinod.koul at intel.com; Anirudha Sarangi;
> pawel.moll at arm.com; mark.rutland at arm.com; ijc+devicetree at hellion.org.uk;
> galak at codeaurora.org; Michal Simek; Soren Brinkmann; Appana Durga
> Kedareswara Rao; devicetree at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH v6 1/2] dmaengine: Add Xilinx Central DMA DT Binding
> Documentation
> 
> On Monday 07 September 2015 18:03:08 Kedareswara rao Appana wrote:
> > +- dma-channel child node: Should have only one channel
> >
> 
> What is the point of the child node if there is only one instance?

Sorry for the delay in reply I was on leave for the last couple weeks.

There are few reasons for these:
---> We (Xilinx) have 3 different DMA's and in order to make consistency b/w the three dma's used the child node concepts so that users can easily compare the drivers
---> It is a soft IP so features like (multiple channels, cyclic dma mode) may added in nearby future so for future driver changes it will be straight forward. 

Please let me know if it is wrong will fix it and will send the next version of the path.

Regards,
Kedar.

> 
> Could you just fold this into the main node instead?
> 
> (Sorry jumping in here without looking at the previous versions, I just returned to
> work from my parental leave).
> 
> 	Arnd
