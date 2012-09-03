From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Mon, 3 Sep 2012 10:01:01 +0800
Subject: [PATCH v4 0/2] dmaengine: add support mmp-pdma
In-Reply-To: <1346424807.15463.11.camel@vkoul-mobl4>
References: <1345083806-24588-1-git-send-email-zhangfei.gao@marvell.com>
 <1346364840.15463.1.camel@vkoul-mobl4>
 <CAMj5BkiF6NGwfbHBgS52EHwTzb+z6x60hSDaqLtQXgk7bB8jUg@mail.gmail.com>
 <1346424807.15463.11.camel@vkoul-mobl4>
Message-ID: <CAMj5BkgbLg-s6jO2inNBcz5srMoUg+jAq4yVn2=c9x_Lr4Bvsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 31, 2012 at 10:53 PM, Vinod Koul <vkoul@infradead.org> wrote:
> On Fri, 2012-08-31 at 09:10 +0800, zhangfei gao wrote:
>> On Fri, Aug 31, 2012 at 6:14 AM, Vinod Koul <vkoul@infradead.org> wrote:
>> > On Thu, 2012-08-16 at 10:23 +0800, Zhangfei Gao wrote:
>> >
>> > What tree is this based on? I do not find
>> > Documentation/devicetree/bindings/dma/mmp-dma.txt in my tree or linus's
>> > tree??
>> >
>>
>> The mmp-dma.txt is created by [PATCH v3 1/4] dmaengine: mmp-pdma support.
>> The patch set based on linux-next, July 13.
> And I cant apply this!!!
>
> It needs to be based on either dmaengine-next or linus master.
>
> Otherwise this should be sent to tree where this file exists, or drop
> the binding and rest can be merged while binding get merged separately,
> I would prefer the last approach
>
> --
> ~Vinod Koul
> Intel Corp.
>

Hi, Vinod,

Sorry for inconvenience.

Will split the patch to 3 patches based on linux.git.
1 is pdma,
2 is update tdma supporting device tree.
3 is adding Documentation/devicetree/bindings/dma/mmp-dma.txt for both
pdma and tdma.

Thanks
