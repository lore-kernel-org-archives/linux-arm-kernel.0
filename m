From: lrg@ti.com (Liam Girdwood)
Date: Wed, 25 May 2011 13:21:39 +0100
Subject: [PATCH] ASoc: sam9g20_wm8731: use the proper SYSCKL value
In-Reply-To: <20110525111545.GD10797@opensource.wolfsonmicro.com>
References: <1306230676-28688-1-git-send-email-nicolas.ferre@atmel.com>
	<20110525111545.GD10797@opensource.wolfsonmicro.com>
Message-ID: <4DDCF453.3070805@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/05/11 12:15, Mark Brown wrote:
> On Tue, May 24, 2011 at 11:51:16AM +0200, Nicolas Ferre wrote:
>> at91sam9g20 is providing master clock to wm8731: not using a crystal but an
>> external MCLK. We can avoid conflict and save power using WM8731_SYSCLK_MCLK as
>> we do not need oscillator to be powered.
>>
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> Adding Liam.
> 

Acked-by: Liam Girdwood <lrg@ti.com>
