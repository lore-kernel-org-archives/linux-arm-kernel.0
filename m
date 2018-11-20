From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed, 21 Nov 2018 00:33:16 +0100
Subject: [PATCH 2/2] arm64: dts: renesas: r8a77965: Add CAN FD controller
 node
In-Reply-To: <20181119104419.aznzc6nafwaaxalw@verge.net.au>
References: <20181118173327.4704-1-marek.vasut+renesas@gmail.com>
 <20181118173327.4704-2-marek.vasut+renesas@gmail.com>
 <20181118231053.GC2553@kunai>
 <647080c6-5b96-a39e-db6e-4426cabc5939@gmail.com>
 <20181119104419.aznzc6nafwaaxalw@verge.net.au>
Message-ID: <f22cb7bc-6aca-b9ed-bd7f-a6c9bae38d4d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/19/2018 11:44 AM, Simon Horman wrote:
> On Mon, Nov 19, 2018 at 12:29:37AM +0100, Marek Vasut wrote:
>> On 11/19/2018 12:10 AM, Wolfram Sang wrote:
>>> On Sun, Nov 18, 2018 at 06:33:27PM +0100, Marek Vasut wrote:
>>>> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>>>>
>>>> This patch adds CAN FD controller nodes for the R8A77965 SoC.
>>>>
>>>> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>>>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>>>> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
>>>> Cc: Rob Herring <robh@kernel.org>
>>>> Cc: Simon Horman <horms+renesas@verge.net.au>
>>>> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
>>>> Cc: linux-renesas-soc at vger.kernel.org
>>>> Cc: linux-arm-kernel at lists.infradead.org
>>>
>>> Why seperate patches for CAN and CANFD here while they are merged for
>>> r8a77990 into one patch?
>>
>> Because they are two different IP blocks, but I can merge the patches
>> together if that's what you want.
> 
> Merging these patches makes sense to me.

Done

-- 
Best regards,
Marek Vasut
