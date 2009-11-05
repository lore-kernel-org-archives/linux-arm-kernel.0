From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 5 Nov 2009 11:14:33 +0800
Subject: [PATCH] Fix PXA-27x/3xx interrupts when CONFIG_PXA_HAVE_ISA_IRQS=y
In-Reply-To: <771cded00911041911qded36d3sf9ce4384e1ad80b6@mail.gmail.com>
References: <20091103210439.2a6c1f20@taxman.wild-wind.fr.eu.org>
	<771cded00911031827m34f36dc7r1bc7e1096bb98690@mail.gmail.com>
	<f17812d70911031920t706d9909w3750a2eb9b1d958@mail.gmail.com>
	<771cded00911041911qded36d3sf9ce4384e1ad80b6@mail.gmail.com>
Message-ID: <f17812d70911041914u534cbd50s4fb57f0b77fcca9c@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> CONFIG_PXA_HAVE_ISA_IRQS is used on some platforms which emulates
>> ISA expansion slots so some legacy ISA cards can still be used on pxa
>> platforms, not necessarily related to pxa25x, could be pxa27x and pxa3xx.
>> We need to take a look into the patch indeed.
>>
>
> I'm OK on this patch. It works well on my platform.
>

So Marc,

Could you please check without that #ifdef .. #endif it still works fine
since my assmption is PXA_IRQ() has taken that into account.
