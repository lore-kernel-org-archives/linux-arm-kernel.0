From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 29 May 2013 20:27:59 +0200
Subject: [PATCH -next] dmaengine: ste_dma40: fix error return code in
 d40_probe()
In-Reply-To: <CAPgLHd-Mw4MQwS8=p9+ZBHHehH7B-Hs49BqiUMrq-aV_5M4pQQ@mail.gmail.com>
References: <CAPgLHd-Mw4MQwS8=p9+ZBHHehH7B-Hs49BqiUMrq-aV_5M4pQQ@mail.gmail.com>
Message-ID: <CACRpkdZH8jai84q6uwSRjMR+HCzohH-JMaKw1SCShYwgSKJYXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 28, 2013 at 11:06 AM, Wei Yongjun <weiyj.lk@gmail.com> wrote:

> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> In many of the error handling case, the return value 'ret' not set
> and 0 will be return from d40_probe() even if error, but we should
> return a negative error code instead in those error handling case.
> This patch fixed them, and also removed useless variable 'err'.
>
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Hm it seems it does not apply on my dma40 branch (the same
as mentioned by Andy):
https://git.kernel.org/cgit/linux/kernel/git/linusw/linux-stericsson.git/log/?h=ux500-dma40

I have already queued some 36 patches from this branch into
ARM SoC so it is in -next today (and conflicting with this patch).

Could you rebase it and get Vinod's ACK so I can queue it?

Also pls include Lee Jones on CC.

Yours,
Linus Walleij
