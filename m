From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Tue, 20 Aug 2013 15:58:41 +0800
Subject: [PATCH v3 1/2] dmaengine: add interface of dma_get_slave_channel
In-Reply-To: <20130819052516.GT32147@intel.com>
References: <1376550163-30145-1-git-send-email-zhangfei.gao@linaro.org>
 <1376550163-30145-2-git-send-email-zhangfei.gao@linaro.org>
 <20130819052516.GT32147@intel.com>
Message-ID: <CAMj5Bkhq=kvfpYiMX0de3PBaAzOUfgPVELamaeMAWhHaoDgc8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> No, this is not the right approach.
>
> When patch is applied and you find an issue you fix the issue. I have already
> pushed and merged this. So removing is a bad idea.
> you provide a fix for this miss.
>
> Also for this you need to give due credit to Dan (reporter). That is how the
> process works.
>
> Anyway I have applied the below fix and will push it out.
>
> ---
> dmaengine: fix - error: potential NULL dereference 'chan'
>
> commit 7bb587f4 "dmaengine: add interface of dma_get_slave_channel" introduced
> the above error so fix it
>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Suggested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>

Thanks Vinod for the kind education.
Understand, will take care next time.

BTW, it is strange I do not see such compile warning here :(
