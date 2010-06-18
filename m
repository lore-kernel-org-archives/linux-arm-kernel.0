From: eric@eukrea.com (=?UTF-8?B?RXJpYyBCw6luYXJk?=)
Date: Fri, 18 Jun 2010 16:37:23 +0200
Subject: [PATCH v2] input/imx_keypad: add PM support
In-Reply-To: <1276856186.3146.5.camel@realization>
References: <1276801147-4103-1-git-send-email-eric@eukrea.com>
	<1276856186.3146.5.camel@realization>
Message-ID: <4C1B84A3.8080300@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alberto,

Le 18/06/2010 12:16, Alberto Panizzo a ?crit :
> Ok, so with this patch the keypad cannot wake the system?
> It is scheduled another patch?
>
well, actually, the keypad wakes the system, at least on my board here.

I was quite surprised to get this working this way as I would have 
expected disable_irq + clk_disable would prevent the keypad from being a 
wake source.
Can you try on your board as this cleanup may be wrong on i.MX3 ?

Thanks,
Eric
