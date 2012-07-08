From: zumeng.chen@windriver.com (Zumeng Chen)
Date: Sun, 8 Jul 2012 15:50:57 +0800
Subject: [PATCH 3/5] ARM: omap3evm: enable VBUS switch for EHCI tranceiver
In-Reply-To: <20120706084105.GR1122@atomide.com>
References: <1340183693-3195-1-git-send-email-zumeng.chen@windriver.com>
 <1340183693-3195-4-git-send-email-zumeng.chen@windriver.com>
 <4FE1BC98.7050607@mvista.com> <20120706084105.GR1122@atomide.com>
Message-ID: <4FF93BE1.1000209@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2012?07?06? 16:41, Tony Lindgren ??:
> * Sergei Shtylyov<sshtylyov@mvista.com>  [120620 05:10]:
>> On 20-06-2012 13:14, Zumeng Chen wrote:
>>> This will set TWL4030.GPIO2 as output pin to drive EHCI tranceiver.
> ...
>
>>> +	/* Enable VBUS switch by setting TWL4030.GPIO2DIR as output
>>> +	 * for starting USB tranceiver
>>> +	 */
>>> +	if (get_omap3_evm_rev()>= OMAP3EVM_BOARD_GEN_2) {
>>> +		u8 val;
>>     Empty line after declaration block wouldn't hurt...
>>
> I'll apply these into devel-board branch with the extra line
> added. Not taking the clock related patch 4/5 as that's something
> Paul should queue.
>
> Also note that the board-*.c files are being phased out with
> devicetree support.
Thanks Tony for your comments, I understand all of them.

Regards,
Zumeng
>
> Regards,
>
> Tony
