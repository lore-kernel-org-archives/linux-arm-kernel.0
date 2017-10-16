From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 16 Oct 2017 12:29:25 +0200
Subject: [PATCH v4 0/9] Mediatek MT2712 clock and scpsys support
In-Reply-To: <1508136134.20464.49.camel@mtksdaap41>
References: <1505793630-12590-1-git-send-email-weiyi.lu@mediatek.com>
 <20171012224540.GE18706@codeaurora.org>
 <ac7940d1-e23d-add2-b4b6-bd7cf66fea34@gmail.com>
 <1508136134.20464.49.camel@mtksdaap41>
Message-ID: <4b2b1a94-2a0e-4c5e-030e-d35edb3ac2f1@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/16/2017 08:42 AM, Weiyi Lu wrote:
> On Fri, 2017-10-13 at 16:50 +0200, Matthias Brugger wrote:
>>
>> On 10/13/2017 12:45 AM, Stephen Boyd wrote:
>>> On 09/19, Weiyi Lu wrote:
>>>> This series is based on v4.14-rc1 and composed of
>>>> clock control (PATCH 1-4) and scpsys control (PATCH 5-9)
>>>
>>> What's the merge plan? Can I apply the clk ones to clk tree and
>>> ignore the rest?
>>>
>>
>> Yes, please do so. I'll take scpsys, which depends on the clock patches.
>>
>> Regards,
>> Matthias
> 
> Hi Stephen & Matthias,
> 
> I will start to separate this patch set into three series
> (clk/scpsys/dts) when I send the next version.
> 

There are no comments on the clk patches, so no need to resend them, if Stephen 
is ok with taking patch 1,2,3.

If you want you can split out patch 4 and 9, but for me it's ok if they go 
together with the scpsys driver. When scpsys is ready I will take them all 
through my tree.

Regards,
Matthias
