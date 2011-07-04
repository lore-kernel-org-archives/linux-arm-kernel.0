From: lrg@ti.com (Liam Girdwood)
Date: Mon, 4 Jul 2011 18:34:10 +0100
Subject: [PATCH] ASoC: wm8731: set the ACTIVE bit if bias ON entered
In-Reply-To: <20110704172856.GF28726@opensource.wolfsonmicro.com>
References: <ccd4b125244271af7978948689cf1dcef37bc06b.1309368631.git.nicolas.ferre@atmel.com>
	<1309517034-26110-1-git-send-email-nicolas.ferre@atmel.com>
	<20110701161506.GC23784@opensource.wolfsonmicro.com>
	<4E118BF6.6010205@atmel.com>
	<20110704172856.GF28726@opensource.wolfsonmicro.com>
Message-ID: <4E11F992.6080506@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/07/11 18:29, Mark Brown wrote:
> On Mon, Jul 04, 2011 at 11:46:30AM +0200, Nicolas Ferre wrote:
> 
>> Ah, ok... but I fear that I do not know the whole system enough for this
>> addition ;-(
>> Do you think you can code this modification, I will be happy to test it,
>> if you want...
> 
> It's pretty trivial - try the below (Liam, are you OK with this if it
> tests OK?):
> 

All fine by me, It's been so long I've forgotten most things about the WM8731 now ;)
