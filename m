From: bart.tanghe@thomasmore.be (Bart Tanghe)
Date: Thu, 15 Jan 2015 13:29:34 +0100
Subject: [PATCH v3] ARM: dts: add bcm2835-pwm bindings
In-Reply-To: <54B6A200.4040209@wwwdotorg.org>
References: <1421227134-8590-1-git-send-email-bart.tanghe@thomasmore.be>
 <54B6A200.4040209@wwwdotorg.org>
Message-ID: <54B7B2AE.3020309@thomasmore.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm really sorry. I've used the wrong source. I make v4.

Regards,

Bart

On 01/14/2015 06:06 PM, Stephen Warren wrote:
> On 01/14/2015 02:18 AM, Bart Tanghe wrote:
>> To probe the bcm2835-pwm driver properly, this dts bindings has to be added
>> to the bcm2835 dtsi file.
>> In expectation of a bcm2835 clock driver, I've added fixed-clock clock binding.
>> ---
>> Changes in v3:
>>   - node added by reg value
> 
> The pwm node still seems to be in the wrong place. Sorting by reg value, it should be after i2c at 20205000 and before sdhci at 7e300000, as I mentioned before.
