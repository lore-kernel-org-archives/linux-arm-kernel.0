From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Thu, 7 Jun 2012 17:59:43 +0800
Subject: [alsa-devel] [PATCH v1 2/5] ASoC: mmp: add audio dma support
In-Reply-To: <1339061042.1927.61.camel@vkoul-udesk3>
References: <1338791851-21038-1-git-send-email-zhangfei.gao@marvell.com>
 <1338791851-21038-3-git-send-email-zhangfei.gao@marvell.com>
 <1339061042.1927.61.camel@vkoul-udesk3>
Message-ID: <CAMj5Bkj+4qQqoDgz_d7eLK+QuVm41fnN5204tRpJ8NKrNsAjcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 7, 2012 at 5:24 PM, Vinod Koul <vinod.koul@linux.intel.com> wrote:
> On Mon, 2012-06-04 at 14:37 +0800, Zhangfei Gao wrote:
>> mmp-pcm handle audio dma based on soc-dmaengine
>> Support mmp and pxa910
> See soc-dmaengine.c. You sneed to use the library to use dmaengine.
>

Thanks Vinod for kind review.

Some confusion, only find sound/soc/soc-dmaengine-pcm.c.
So the driver base on the library, snd_dmaengine_pcm_open/close etc.
Replacing dma_request_channel etc.

Is it right direction?
