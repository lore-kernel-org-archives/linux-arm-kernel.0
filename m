From: baolin.wang@linaro.org (Baolin Wang)
Date: Thu, 24 May 2018 13:27:13 +0800
Subject: [PATCH] arm64: dts: sprd: fix typo in 'remote-endpoint'
In-Reply-To: <CAL_JsqKrsTpgnLfxhcxeucpoh9NkyGwwZq82QUBgJZrdjGYQzg@mail.gmail.com>
References: <20180508150952.24562-1-robh@kernel.org>
 <20180508150952.24562-4-robh@kernel.org>
 <CAAfSe-tgKJvzCN6eHCuUR94ECSE8ypAR1eRjhV-VJNztebK9Xw@mail.gmail.com>
 <CAL_JsqKrsTpgnLfxhcxeucpoh9NkyGwwZq82QUBgJZrdjGYQzg@mail.gmail.com>
Message-ID: <CAMz4kuKVknMt578MGCnP_wzLB_o-yttHXD9uxbFBDXYq6XiTRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 May 2018 at 04:30, Rob Herring <robh@kernel.org> wrote:
> On Tue, May 8, 2018 at 8:58 PM, Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>> Hi Rob,
>>
>> On 8 May 2018 at 23:09, Rob Herring <robh@kernel.org> wrote:
>>> dtc now warns on incomplete OF graph endpoint connections:
>>>
>>> arch/arm64/boot/dts/sprd/sp9860g-1h10.dtb: Warning (graph_endpoint): /soc/stm at 10006000/port/endpoint: graph connection to node '/soc/funnel at 10001000/ports/port at 2/endpoint' is not bidirectional
>>>
>>> The cause is a typo in 'remote-endpoint'.
>>
>> Thanks for fixing this and,
>>
>> Acked-by: Chunyan Zhang <zhang.lyra@gmail.com>
>
> Is someone going to apply this? Still seeing warnings in linux-next.

I think Arnd will pick up this patch.

-- 
Baolin.wang
Best Regards
