From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 21 Sep 2012 15:34:39 +0800
Subject: [PATCH] ARM: pxa: fix return value check in
 pxa2xx_drv_pcmcia_probe()
In-Reply-To: <CAMPhdO-+7myDOLNxRs8Pi78for3g8+-npsY+EbOa+sxoW=2C1w@mail.gmail.com>
References: <CAPgLHd8ZQr2-1B2QcwO83gJNBrzw-WY1WWgWQJJCQYxirVAC2Q@mail.gmail.com>
 <CAMPhdO-+7myDOLNxRs8Pi78for3g8+-npsY+EbOa+sxoW=2C1w@mail.gmail.com>
Message-ID: <CAN1soZz2wuTR6QkKkr74QN3=BZVKRjQSGvh5cKpqY9bHivxvcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2012 at 3:30 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> On Fri, Sep 21, 2012 at 3:19 PM, Wei Yongjun <weiyj.lk@gmail.com> wrote:
>> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>>
>> In case of error, the function clk_get() returns ERR_PTR()
>> and never returns NULL pointer. The NULL test in the error
>> handling should be replaced with IS_ERR().
>>
>> dpatch engine is used to auto generated this patch.
>> (https://github.com/weiyj/dpatch)
>>
>> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> Ack
>
Applied

Thanks
Haojian
