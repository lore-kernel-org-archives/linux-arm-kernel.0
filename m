From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 13 Jun 2014 09:24:05 -0600
Subject: [PATCH v2 1/3] arm: multi_v7: enable igb, stmpe, lm95245, pwm leds
In-Reply-To: <201406131610.18048.arnd@arndb.de>
References: <1741a33cd88cd5525f3c50c0e0cacc0853a3512a.1402350905.git.marcel@ziswiler.com>
 <201406131610.18048.arnd@arndb.de>
Message-ID: <539B1795.1060507@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/13/2014 08:10 AM, Arnd Bergmann wrote:
> On Tuesday 10 June 2014, Marcel Ziswiler wrote:
>> The NVIDIA Tegra 3 based Apalis T30 module contains an Intel i210 resp.
>> i211 gigabit Ethernet controller, an STMPE811 ADC/touch controller, PWM
>> LEDs generically accessible from user space and an LM95245 temperature
>> sensor chip. The later three can also be found on the Colibri T30
>> module.
>>
>> While at it move the NEON entry down to its proper place to have it all
>> nicely ordered again.
>>
>> Signed-off-by: Marcel Ziswiler <marcel@ziswiler.com>
> 
> Stephen, Thierry,
> 
> do you want me to queue it up directly, or do you want to put it into
> a tegra fixes branch?

Taking this first patch through arm-soc is easiest to avoid conflicts on
the shared file. I'll take 2 and 3 through the Tegra tree.
