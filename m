From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 17 Dec 2012 11:23:20 +0100
Subject: [Resend PATCH v6 1/4] pinctrl: atmel-ssc: add pinctrl support
In-Reply-To: <20121217093947.GG23971@game.jcrosoft.org>
References: <1353464229-20846-1-git-send-email-voice.shen@atmel.com>
 <20121121022441.GJ4673@opensource.wolfsonmicro.com>
 <20121217093947.GG23971@game.jcrosoft.org>
Message-ID: <50CEF298.3070508@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/17/2012 10:39 AM, Jean-Christophe PLAGNIOL-VILLARD :
> On 11:24 Wed 21 Nov     , Mark Brown wrote:
>> On Wed, Nov 21, 2012 at 10:17:09AM +0800, Bo Shen wrote:
>>> Add pinctrl support for atmel ssc peripheral
>>>
>>> Signed-off-by: Bo Shen <voice.shen@atmel.com>
>>
>> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
> you handle this one with scc

Hold on Jean-Christophe, I made a little experiment this morning, and
this patch is not applying correctly on:
- linus' tree
- linux-next
- neither Mark's for-next branch

So, *I* will manage this patch and try to make sure that Mark is able to
seamlessly include it in his tree on top of a known source for a future
ASoC "fixes" pull-request.

Mark, what about rebasing this one on top of current Linus' tree
(toguether with the one that you have just applied on the topic/atmel
branch: (ASoC: atmel-ssc: change disable to disable in dts node)?

I hope that once reworked, they will be able to reach Linus' tree soon
because the lack of this patch is causing DTB compilation errors on all
AT91...


Best regards,
-- 
Nicolas Ferre
