From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 20 Dec 2012 16:51:43 +0100
Subject: [PATCH 1/3] ARM: AT91: IIO: add low and high res support for adc
In-Reply-To: <50D2EDE6.3090706@atmel.com>
References: <20121219183236.GP23971@game.jcrosoft.org>
 <1355942232-26251-1-git-send-email-plagnioj@jcrosoft.com>
 <50D2EBA1.4050305@free-electrons.com> <50D2EDE6.3090706@atmel.com>
Message-ID: <50D3340F.3090209@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ludovic,

Le 20/12/2012 11:52, ludovic.desroches a ?crit :
>> I'm wondering, why are you using such a complex dt parsing code, and
>> bindings, when you only requires a boolean to switch between 8 and 10
>> bits mode (which seem to be the only thing you support)?
> 
> We will have a 10 and 12 bits mode on future ADCs and I would like to
> have something which could manage more than two resolutions if it
> happens one day.

I see your point. I'm not fond at all of the existing bindings for the
driver (putting things like registers offset in the dt is a non-sense to
me, but hey...), so I'd like to still keep it as simple and non-bloated
as possible, but it's true that in the current situation, we probably
have no other choice.

Maxime
-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
