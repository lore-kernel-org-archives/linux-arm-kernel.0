From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed, 7 Nov 2018 11:59:57 +0100
Subject: [PATCH V3] arm64: dts: r8a77990: ebisu: Add and enable SDHI
 device nodes
In-Reply-To: <20181107085056.GB31092@kunai>
References: <20181106204647.18051-1-marek.vasut+renesas@gmail.com>
 <20181107085056.GB31092@kunai>
Message-ID: <7154affe-751a-7cb4-48ea-3d4d6f467ac8@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/07/2018 09:50 AM, Wolfram Sang wrote:
> On Tue, Nov 06, 2018 at 09:46:47PM +0100, Marek Vasut wrote:
>> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>>
>> This patch adds SDHI{0,1,3} device nodes for the r8a77990 SoC
>> and enables SD card slot connected to SDHI0, micro SD card slot
>> connected to SDHI1 and eMMC connected to SDHI3 on the Ebisu board
>> using the R8A77990 SoC.
>>
>> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> 
> Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Out of curiosity: have you tested HS400 on that board based on Niklas'
> recent patches as well?

Nope. I tried that patchset on M3N again yesterday and got error -84
while initing the eMMC, so I need to look into that first. Then I'll
try it on E3.

-- 
Best regards,
Marek Vasut
