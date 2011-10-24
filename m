From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 24 Oct 2011 10:09:09 +0200
Subject: [PATCH 1/3] ARM: Samsung: Move timer irq numbers to end of linux
	irq	space
In-Reply-To: <20111021194517.GA3722@ponder.secretlab.ca>
References: <1318234289-22041-1-git-send-email-thomas.abraham@linaro.org>
	<1318234289-22041-2-git-send-email-thomas.abraham@linaro.org>
	<001001cc8d6d$5c48fa60$14daef20$%youn@samsung.com>
	<017001cc8fd7$c27e4ee0$477aeca0$%kim@samsung.com>
	<20111021194517.GA3722@ponder.secretlab.ca>
Message-ID: <4EA51D25.9060802@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 10/21/11 21:45, Grant Likely wrote:
> On Fri, Oct 21, 2011 at 06:56:52PM +0900, Kukjin Kim wrote:
>> Changhwan Youn wrote:
>>>
>>> Hi Thomas,
>>>
>>> All UART_IRQ_RXD, TXD, ERR of Samsung's platforms are also statically
>>> mapped to linux irq numbers 16 to 31. These interrupts also need proper
>> handling.
>>>
>>> Best regards,
>>> Changhwan Youn
>>>
>>
>> Hi all,
>>
>> Hmm, I'd like to apply Thomas' device tree series for EXYNOS4 and Samsung
>> stuff for upcoming merge window but there are still some comments on some
>> stuff and that should be fixed before applying. In addition I need to keep
>> the ordering to apply them to avoid conflicts. But as you know, v3.1 is now
>> close at hand and we don't have enough time for it now :(
>>
>> I will leave tomorrow morning (KST) for KS. I will talk to Grant Likely
>> about this in Prague :)
>
> One of the goals I have for the hacking summit is to get as much of
> the outstanding DT patches queued up and into linux-next.
>
OK.

I talked to Grant at ARM Subarch Workshop.

I will apply Thomas' DT patches into Samsung tree and it will be sent to 
upstream via arm-soc for upcoming merge window v3.2 and if any fixing is 
required, we will do it during -rc.

Thomas, if any problems during apply, let you know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
