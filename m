From: B29396@freescale.com (Dong Aisheng-B29396)
Date: Sat, 31 Mar 2012 12:39:07 +0000
Subject: [alsa-devel] [PATCH 1/1] ASoC: soc-dmaengine-pcm: fix compile
 error	since dma api is changed
In-Reply-To: <4F76EB8D.2060200@metafoo.de>
References: <1333197468-3263-1-git-send-email-b29396@freescale.com>
 <4F76EB8D.2060200@metafoo.de>
Message-ID: <7FE21149F4667147B645348EC6057885153794@039-SN2MPN1-011.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Lars-Peter Clausen [mailto:lars at metafoo.de]
> Sent: Saturday, March 31, 2012 7:34 PM
> To: Dong Aisheng-B29396
> Cc: alsa-devel at alsa-project.org; broonie at opensource.wolfsonmicro.com;
> lrg at ti.com; linux-arm-kernel at lists.infradead.org
> Subject: Re: [alsa-devel] [PATCH 1/1] ASoC: soc-dmaengine-pcm: fix
> compile error since dma api is changed
> Importance: High
> 
> On 03/31/2012 02:37 PM, Dong Aisheng wrote:
> > From: Dong Aisheng <dong.aisheng@linaro.org>
> >
> > The following compiling error is caused by the API
> > device_prep_dma_cyclic is changed. Using dmaengine_prep_dma_cyclic to
> fix it.
> >
> > sound/soc/soc-dmaengine-pcm.c: In function
> 'dmaengine_pcm_prepare_and_submit':
> > sound/soc/soc-dmaengine-pcm.c:149: error: too few arguments to function
> 'chan->device->device_prep_dma_cyclic'
> > make[2]: *** [sound/soc/soc-dmaengine-pcm.o] Error 1
> > make[1]: *** [sound/soc] Error 2
> > make: *** [sound] Error 2
> >
> 
> Hi,
> 
> There is already a fix for this in Mark's for-3.4 branch.
Okay, thanks for reminder.
I missed to check Mark's tree.

Regards
Dong Aisheng
