From: vkoul@kernel.org (Vinod)
Date: Thu, 17 May 2018 16:25:17 +0530
Subject: [PATCH] dmaengine: qcom: bam_dma: fix some doc warnings.
In-Reply-To: <c3b63215-ed0f-93ee-69df-6b22053f0479@linaro.org>
References: <20180517095916.11362-1-srinivas.kandagatla@linaro.org>
 <20180517105049.GZ13271@vkoul-mobl>
 <c3b63215-ed0f-93ee-69df-6b22053f0479@linaro.org>
Message-ID: <20180517105517.GA13271@vkoul-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17-05-18, 11:53, Srinivas Kandagatla wrote:
> 
> 
> On 17/05/18 11:50, Vinod Koul wrote:
> > On 17-05-18, 10:59, Srinivas Kandagatla wrote:
> > > diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> > > index 4a828c18099a..a05fff8a1447 100644
> > > --- a/drivers/dma/qcom/bam_dma.c
> > > +++ b/drivers/dma/qcom/bam_dma.c
> > > @@ -451,7 +451,7 @@ static void bam_reset_channel(struct bam_chan *bchan)
> > >   /**
> > >    * bam_chan_init_hw - Initialize channel hardware
> > >    * @bchan: bam channel
> > > - *
> > > + * @dir: DMA transfer direction
> > 
> > Do you want to add an empty line here?
> > 
> TBH, Am not 100% sure it it adds any value.
> 
> Most of the function docs in the file have this same issue.. :-)
> 
> let me know if you still want an empty line, I can respin.

Yeah that's why asked, I can edit while applying so no issues

-- 
~Vinod
