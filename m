From: lrg@ti.com (Liam Girdwood)
Date: Wed, 25 May 2011 13:11:55 +0100
Subject: [PATCH] ASoc: wm8731: fix wm8731_check_osc() connected condition
In-Reply-To: <20110525111529.GC10797@opensource.wolfsonmicro.com>
References: <1306230657-28649-1-git-send-email-nicolas.ferre@atmel.com>
	<20110525111529.GC10797@opensource.wolfsonmicro.com>
Message-ID: <4DDCF20B.4080701@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/05/11 12:15, Mark Brown wrote:
> On Tue, May 24, 2011 at 11:50:57AM +0200, Nicolas Ferre wrote:
>> The crystal oscillator is only enabled if the WM8731_SYSCLK_XTAL master clock
>> is specified. Fix the connected() struct snd_soc_dapm_route function to take
>> this into account. Oscillator is not enabled on machine that need it otherwise.
>>
>> Machine drivers have to make sure that they use the proper SYSCLK value.
>>
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> Adding Liam - Nicolas, please remember to CC all maintainers on patches.
> 

Acked-by: Liam Girdwood <lrg@ti.com>
