From: thomas.weber.linux@googlemail.com (Thomas Weber)
Date: Thu, 20 Jan 2011 07:56:55 +0100
Subject: [PATCHv4 2/4] OMAP3: Devkit8000: Fix tps65930 pullup/pulldown
	configuration
In-Reply-To: <20110119222126.GI4957@atomide.com>
References: <1295425166-25540-1-git-send-email-weber@corscience.de>
	<1295425166-25540-3-git-send-email-weber@corscience.de>
	<20110119222126.GI4957@atomide.com>
Message-ID: <4D37DCB7.9010505@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 19.01.2011 23:21, schrieb Tony Lindgren:
> * Thomas Weber <weber@corscience.de> [110119 00:18]:
>> From: Daniel Morsing <daniel.morsing@gmail.com>
>>
>> gpio7 on the tps65930 is used as an output on the devkit8000 and
>> gpio1 is not connected. Remove gpio7 and change gpio1 to pulldown
>>
>> Signed-off-by: Daniel Morsing <daniel.morsing@gmail.com>
> 
> I'll queue only this fix for now, looks like the other still need
> minor changes.
> 
> Tony
> --

Thanks.
