From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Wed, 16 Mar 2016 06:12:55 +0000
Subject: [PATCH 2/7] dmaengine: xilinx_vdma: Add quirks support to
 differentiate differnet IP cores
In-Reply-To: <20160316031350.GN13211@localhost>
References: <1458062592-27981-1-git-send-email-appanad@xilinx.com>
 <1458062592-27981-3-git-send-email-appanad@xilinx.com>
 <20160316031350.GN13211@localhost>
Message-ID: <C246CAC1457055469EF09E3A7AC4E11A4A56D2CD@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

> -----Original Message-----
> From: dmaengine-owner at vger.kernel.org [mailto:dmaengine-
> owner at vger.kernel.org] On Behalf Of Vinod Koul
> Sent: Wednesday, March 16, 2016 8:44 AM
> To: Appana Durga Kedareswara Rao
> Cc: dan.j.williams at intel.com; Michal Simek; Soren Brinkmann; Appana Durga
> Kedareswara Rao; moritz.fischer at ettus.com;
> laurent.pinchart at ideasonboard.com; luis at debethencourt.com; Anirudha
> Sarangi; dmaengine at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> linux-kernel at vger.kernel.org
> Subject: Re: [PATCH 2/7] dmaengine: xilinx_vdma: Add quirks support to
> differentiate differnet IP cores
> 
> On Tue, Mar 15, 2016 at 10:53:07PM +0530, Kedareswara rao Appana wrote:
> > This patch adds quirks support in the driver to differentiate differnet IP cores.
> 
> Wouldn't it help to explain why quirks are needed for these cores in changelog?

Will fix in the next version.

> 
> Also limit your changelogs properly. Am sure checkpatch would have warned
> you!

Sure will fix in the next version sorry for the noise.

Thanks,
Kedar.

> 
> --
> ~Vinod
> --
> To unsubscribe from this list: send the line "unsubscribe dmaengine" in the body
> of a message to majordomo at vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
