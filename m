From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Mon, 5 Oct 2015 13:01:15 +0000
Subject: [PATCH v9] dmaengine: Add Xilinx AXI Direct Memory Access
 Engine driver support
In-Reply-To: <CAAtXAHc_wfuzW=ERRqvjcd_Ow5e2RrEcDkiYRuotzCRhq+oUYQ@mail.gmail.com>
References: <1440432666-10310-1-git-send-email-appanad@xilinx.com>
 <CAAtXAHccn5UjCg9Qr1Li1c9LfsBXrgF=gpMqJ6stGOaWL0u_-g@mail.gmail.com>
 <55E00050.2020709@xilinx.com>
 <CAAtXAHc_wfuzW=ERRqvjcd_Ow5e2RrEcDkiYRuotzCRhq+oUYQ@mail.gmail.com>
Message-ID: <C246CAC1457055469EF09E3A7AC4E11A4A4EC0F2@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

	I didn't get any comments on this patch since last few weeks.
Apart from the Moritz clock framework related comments and it is addressed by Michal.
If you are ok with this patch could you please apply it?

Regards,
Kedar.

> -----Original Message-----
> From: Moritz Fischer [mailto:moritz.fischer at ettus.com]
> Sent: Monday, September 21, 2015 10:47 PM
> To: Michal Simek
> Cc: Appana Durga Kedareswara Rao; Vinod Koul; Dan Williams; Soren
> Brinkmann; Appana Durga Kedareswara Rao; anirudha at xilinx.com;
> dmaengine at vger.kernel.org; linux-arm-kernel; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH v9] dmaengine: Add Xilinx AXI Direct Memory Access Engine
> driver support
> 
> Hi Kedar,
> 
> I finally got around to test your stuff on hardware. Sorry it took me so long.
> 
> [    5.486709] dma1chan0-dma1c: terminating after 5 tests, 0 failures (status 0)
> 
> So it looks like it's working. You can already add a
> 
> Tested-by: Moritz Fischer <moritz.fischer@ettus.com>
> 
> for the driver.
> 
> I'll take a closer look at the code this week now that I have a known good bit
> file.
> 
> Thanks,
> 
> Moritz
