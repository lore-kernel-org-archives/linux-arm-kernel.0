From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 3 Mar 2016 13:36:07 +0100
Subject: [PATCH 00/17] Add Initial support for PLX Technology OX810SE
In-Reply-To: <2685005.KXG3SqulNM@wuerfel>
References: <1457005210-18485-1-git-send-email-narmstrong@baylibre.com>
 <2685005.KXG3SqulNM@wuerfel>
Message-ID: <56D82FB7.8020006@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/03/2016 01:23 PM, Arnd Bergmann wrote:
> Looks very nice overall. I think with the timing, it's a way too
> late for 4.6 now, but there should be no problem merging this for 4.7.
> I assume it's not urgent on your end, as this seems to be a somewhat
> historic platform.

Yes, it's not urgent, I will certainly post a v2 following your device tree comments.

> I had no idea there was an ARM9 based predecessor of OX820SE, so I was
> surprised to see this one instead. How closely related are they?
They seem very close, the only differences seems to be in the MP CORE, the SATA
IP and the pinctrl.

> 
> 	Arnd
> 

Thanks !

Neil
