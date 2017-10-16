From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 16 Oct 2017 17:09:14 +0200
Subject: [PATCH 3/3] arm64: dts: mt2712: Add auxadc device node.
In-Reply-To: <0e1bac27-18ca-121c-f1d7-8063af177a8b@gmail.com>
References: <1505957212-13402-1-git-send-email-zhiyong.tao@mediatek.com>
 <1505957212-13402-4-git-send-email-zhiyong.tao@mediatek.com>
 <20170924164705.78cbb856@archlinux>
 <0e1bac27-18ca-121c-f1d7-8063af177a8b@gmail.com>
Message-ID: <6680d15a-625a-cc16-830f-9831f5f52ad3@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/13/2017 05:11 PM, Matthias Brugger wrote:
> 
> 
> On 09/24/2017 05:47 PM, Jonathan Cameron wrote:
>> On Thu, 21 Sep 2017 09:26:52 +0800
>> Zhiyong Tao <zhiyong.tao@mediatek.com> wrote:
>>
>>> Add auxadc device node for MT2712.
>>>
>>> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
>>
>> I've applied the IIO patches to make this work, so assume this will get
>> picked up in due course.
>>
> 
> pushed now to v4.14-next/dts64
> Thanks.
> 

I realized that this needs the mt2712 clock patches to actually work.
Dropped for now. Please resubmit as soon as mt2712 clock patches got [1] 
accepted upstream.

Thanks,
Matthias

[1] https://lkml.org/lkml/2017/9/19/9
