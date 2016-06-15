From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 15 Jun 2016 13:43:48 +0300
Subject: [PATCH v5 05/12] ARM: shmobile: r8a7792: add SMP support
In-Reply-To: <20160615023030.GC19186@verge.net.au>
References: <14666252.G84Ipxe6EL@wasted.cogentembedded.com>
 <8892035.WlgqvXCvaR@wasted.cogentembedded.com>
 <20160615023030.GC19186@verge.net.au>
Message-ID: <dd2af098-c5ff-66a5-9812-f6b9956f401a@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/15/2016 5:30 AM, Simon Horman wrote:

>> Add R8A7792 SMP support using the shared APMU code. This SoC has 2 ARM
>> Cortex-A15  CPU cores.
>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
> I apologise for not raising this earlier.
>
> I would like you to remove SMP support from this series as I do
> not wish to merge any more per-SoC C SMP code for Gen-2 SoCs.
>
> Rather, I believe the future is to use generic code to support
> the APMU hardware and then describe it in DT. Something like this:
>
> http://www.spinics.net/lists/linux-sh/msg45229.html

    Sigh...

> As that code is not merged my suggestion is that we merge UP r8a7792 for
> now. This is the same approach that has been taken for the r8a7793.

    It should be enough to drop the SMP patch from the series. Could you do it 
or should I repost again?

> Thanks!

MBR, Sergei
