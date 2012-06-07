From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Thu, 07 Jun 2012 15:35:47 +0530
Subject: [alsa-devel] [PATCH v1 2/5] ASoC: mmp: add audio dma support
In-Reply-To: <CAMj5Bkj+4qQqoDgz_d7eLK+QuVm41fnN5204tRpJ8NKrNsAjcg@mail.gmail.com>
References: <1338791851-21038-1-git-send-email-zhangfei.gao@marvell.com>
 <1338791851-21038-3-git-send-email-zhangfei.gao@marvell.com>
 <1339061042.1927.61.camel@vkoul-udesk3>
 <CAMj5Bkj+4qQqoDgz_d7eLK+QuVm41fnN5204tRpJ8NKrNsAjcg@mail.gmail.com>
Message-ID: <1339063547.1927.63.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-06-07 at 17:59 +0800, zhangfei gao wrote:
> On Thu, Jun 7, 2012 at 5:24 PM, Vinod Koul <vinod.koul@linux.intel.com> wrote:
> > On Mon, 2012-06-04 at 14:37 +0800, Zhangfei Gao wrote:
> >> mmp-pcm handle audio dma based on soc-dmaengine
> >> Support mmp and pxa910
> > See soc-dmaengine.c. You sneed to use the library to use dmaengine.
> >
> 
> Thanks Vinod for kind review.
> 
> Some confusion, only find sound/soc/soc-dmaengine-pcm.c.
> So the driver base on the library, snd_dmaengine_pcm_open/close etc.
> Replacing dma_request_channel etc.
> 
> Is it right direction?
Yes your driver should use it. See examples in other soc drivers


-- 
~Vinod
