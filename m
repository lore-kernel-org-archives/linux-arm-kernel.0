From: voice.shen@atmel.com (Bo Shen)
Date: Fri, 16 Nov 2012 14:33:50 +0800
Subject: [Resend v6 PATCH 2/2] ASoC: atmel-ssc: add pinctrl consumer
In-Reply-To: <20121116061250.GP4387@opensource.wolfsonmicro.com>
References: <1353045837-19474-1-git-send-email-voice.shen@atmel.com>
 <1353045837-19474-2-git-send-email-voice.shen@atmel.com>
 <20121116061250.GP4387@opensource.wolfsonmicro.com>
Message-ID: <50A5DE4E.80206@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 11/16/2012 14:12, Mark Brown wrote:
> On Fri, Nov 16, 2012 at 02:03:57PM +0800, Bo Shen wrote:
>> Add pinctrl consumer for atmel ssc peripheral
>>
>> Signed-off-by: Bo Shen <voice.shen@atmel.com>
>> ---
>> Resend:
>>    Split one patch into two.
>>      - one add pinctrl nodes
>>      - one add pinctrl consumer
>
> No, this isn't what was meant - the idea is to send only the addition of
> pinctrl data as one patch, based off the ASoC branch instead of -next.

What is the pinctrl data? (This patch can be applied on 
sound/topic/atmel branch without any conflicts)
The other one add pinctrl nodes, must based on -next, or else I don't 
know where should I add the pinctrl nodes.

Best Regards,
Bo Shen
