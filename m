From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 22 Aug 2018 17:43:11 +0300
Subject: [PATCH 2/2] arm64: dts: renesas: v3msk: add eMMC support
In-Reply-To: <20180822113100.edpyplj2kteomr2j@verge.net.au>
References: <1af46bf9-d9e5-8dcf-0ac7-a85e7348a34e@cogentembedded.com>
 <9da672a2-0269-4860-8912-189414b43d4c@cogentembedded.com>
 <20180822113100.edpyplj2kteomr2j@verge.net.au>
Message-ID: <9f94612a-5035-b006-f6af-6bafb7ff91f3@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/22/2018 02:31 PM, Simon Horman wrote:

>> Add the eMMC chip support for the V3M Started Kit board.
>>
>> Based on the original (and large) patches by Vladimir Barinov.
>>
>> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> Thanks,
> 
> This looks fine to me but I will wait to see if there are other reviews
> before applying.
> 
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> 
> I am, however, curious to know about HS200.
> Is it supported on the v3msk? If so, do you have any plans to enable it?

   As I've already said, the eMMC chip only receives 3.3V on all its voltage inputs.

MBR, Sergei
