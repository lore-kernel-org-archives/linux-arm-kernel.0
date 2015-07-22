From: noralf@tronnes.org (=?UTF-8?B?Tm9yYWxmIFRyw7hubmVz?=)
Date: Wed, 22 Jul 2015 16:07:57 +0200
Subject: [PATCH] irqchip: bcm2835: Add FIQ support
In-Reply-To: <55822C71.2040409@wwwdotorg.org>
References: <1434130016-26574-1-git-send-email-noralf@tronnes.org>
 <55822C71.2040409@wwwdotorg.org>
Message-ID: <55AFA3BD.80507@tronnes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Den 18.06.2015 04:26, skrev Stephen Warren:
> On 06/12/2015 11:26 AM, Noralf Tr?nnes wrote:
>> Add a duplicate irq range with an offset on the hwirq's so the
>> driver can detect that enable_fiq() is used.
>> Tested with downstream dwc_otg USB controller driver.
> This basically looks OK, but a few comments/thoughts:
>
> a) Should the Kconfig change be a separate patch since it's a separate
> subsystem?

Is this a yes since you haven't acked it?
