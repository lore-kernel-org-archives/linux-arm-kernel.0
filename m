From: joel@jms.id.au (Joel Stanley)
Date: Wed, 28 Mar 2018 11:02:18 +1030
Subject: [PATCH 1/2 v2] ARM: dts: Add Aspeed SoC USB controllers to
 device-tree
In-Reply-To: <1516031982.5522.3.camel@aj.id.au>
References: <1515738064.31850.100.camel@kernel.crashing.org>
 <1516031982.5522.3.camel@aj.id.au>
Message-ID: <CACPK8XcrcKQSX5Eq3Cq26j1W9kJJezF+AR3pDu6U-MyWS+2yhg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 January 2018 at 02:29, Andrew Jeffery <andrew@aj.id.au> wrote:
> On Fri, 2018-01-12 at 17:21 +1100, Benjamin Herrenschmidt wrote:
>> This adds the USB controllers to the DT template of the
>> AST24xx and AST25xx SoCs.
>>
>> This patch doesn't enable them by default on any board specific
>> .dts yet. This will be done when we have the necessary clock/reset
>> and pinmux support. In the meantime though, this will work if
>> u-boot configures things properly.
>>
>> For the AST2400 I only added pinmux definition for port 1
>> which is dual USB1/USB2. There are additional USB1 only ports
>> that might require more work but I don't have HW to test at
>> hand so I'm leaving that to whoever cares.
>>
>> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> ---
>>
>> v2: Previous patch was missing actually adding the nodes
>>     (which was an old patch in my tree I had forgotten to
>>     merge).
>>
>>  arch/arm/boot/dts/aspeed-g4.dtsi | 27 +++++++++++++++++++++++++++
>>  arch/arm/boot/dts/aspeed-g5.dtsi | 40 ++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 67 insertions(+)

> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

This one also slipped through the cracks. I have applied it to the
aspeed tree with Andrew's review.

Cheers,

Joel
