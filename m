From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Mon, 02 Apr 2012 09:20:04 +0530
Subject: [alsa-devel] [PATCH 1/1] ASoC: soc-dmaengine-pcm: fix compile
 error	since dma api is changed
In-Reply-To: <7FE21149F4667147B645348EC6057885153794@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1333197468-3263-1-git-send-email-b29396@freescale.com>
 <4F76EB8D.2060200@metafoo.de>
 <7FE21149F4667147B645348EC6057885153794@039-SN2MPN1-011.039d.mgd.msft.net>
Message-ID: <1333338604.1610.0.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2012-03-31 at 12:39 +0000, Dong Aisheng-B29396 wrote:
> > > sound/soc/soc-dmaengine-pcm.c: In function
> > 'dmaengine_pcm_prepare_and_submit':
> > > sound/soc/soc-dmaengine-pcm.c:149: error: too few arguments to
> function
> > 'chan->device->device_prep_dma_cyclic'
> > > make[2]: *** [sound/soc/soc-dmaengine-pcm.o] Error 1
> > > make[1]: *** [sound/soc] Error 2
> > > make: *** [sound] Error 2
> > >
> > 
> > Hi,
> > 
> > There is already a fix for this in Mark's for-3.4 branch.
> Okay, thanks for reminder.
> I missed to check Mark's tree.
> 
This fix is there in rc1

-- 
~Vinod
