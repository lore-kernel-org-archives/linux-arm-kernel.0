From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 3 Jun 2016 17:33:35 +0300
Subject: [PATCH 09/13] ARM: dts: r8a7792: add [H]SCIF support
In-Reply-To: <20160601011348.GI20527@verge.net.au>
References: <13205049.n7pM8utpHF@wasted.cogentembedded.com>
 <1493287.pGnW6U6caN@wasted.cogentembedded.com>
 <20160601011348.GI20527@verge.net.au>
Message-ID: <d2580ae5-8b07-a6d8-3503-d04f2a755b16@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01/2016 04:13 AM, Simon Horman wrote:

>> Describe [H]SCIFs in the R8A7792 device tree.
>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
> This looks correct to me.
>
> I am wondering if you have been able to confirm DMA operation of the
> devices enabled later on in the series.

    The SCIF DMA seems to work now that enabled it in the driver. Not sure 
what you meant by "the devices enabled later in the seties"...

MBR, Sergei
