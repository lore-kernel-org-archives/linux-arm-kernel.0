From: thommycheck@gmx.de (Thomas Kunze)
Date: Mon, 12 Oct 2009 19:31:52 +0200
Subject: [PATCH 5/9] SA1100: make gpio_to_irq and reverse a macro
In-Reply-To: <20091011121512.GB1356@ucw.cz>
References: <1254778533-3529-1-git-send-email-thommycheck@gmx.de>	<1254778533-3529-2-git-send-email-thommycheck@gmx.de>	<1254778533-3529-3-git-send-email-thommycheck@gmx.de>	<1254778533-3529-4-git-send-email-thommycheck@gmx.de>	<1254778533-3529-5-git-send-email-thommycheck@gmx.de>	<1254778533-3529-6-git-send-email-thommycheck@gmx.de>
	<20091011121512.GB1356@ucw.cz>
Message-ID: <4AD36808.5030506@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pavel Machek wrote:
> Hi!
>
>   
>> The function can't be used for static initialisations so
>> convert them to macros.
>>
>> Signed-off-by: Thomas Kunze <thommycheck@gmx.de>
>>     
>
> Do you actually use them in initializers?
>   
Yes the last patch of the series does.
