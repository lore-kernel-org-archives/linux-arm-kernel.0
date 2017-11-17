From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 17 Nov 2017 19:11:18 +0300
Subject: [PATCH 1/2] arm64: dts: renesas: r8a77970: add GPIO support
In-Reply-To: <20171117141950.r6vzq6ndapopfidr@verge.net.au>
References: <20171113213149.295833059@cogentembedded.com>
 <CAMuHMdX9n6U8vP0NWRW0hFZqLQbMKvcf4U1HZkP4nJdaS4-qNg@mail.gmail.com>
 <20171117141950.r6vzq6ndapopfidr@verge.net.au>
Message-ID: <e64bc97b-28b2-a8b5-cde7-804f1a3e24f7@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/17/2017 05:19 PM, Simon Horman wrote:

>>> Describe all 6 GPIO controllers in the R8A77970 device tree.
>>>
>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>
>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Thanks, applied.

    It doesn't build w/o PFC support (and I thought I mde it clearin the cover 
letter), so please either merge R8A77970 PFC patch or pull this one out!

MBR, Segei
