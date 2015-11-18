From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Wed, 18 Nov 2015 15:16:58 +0000
Subject: [PATCH v3] ARM: xip: Use correct symbol for end of ROM marker
In-Reply-To: <alpine.LFD.2.20.1511172129060.22569@knanqh.ubzr>
References: <1447362108-4333-1-git-send-email-chris.brandt@renesas.com>
 <1447697140-4099-1-git-send-email-chris.brandt@renesas.com>
 <alpine.LFD.2.20.1511161515100.5826@knanqh.ubzr>
 <HK2PR06MB05619FACB3725B6F5B2299718A1E0@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <alpine.LFD.2.20.1511161605070.5826@knanqh.ubzr>
 <HK2PR06MB056196B2E169A504A16ED9738A1D0@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <alpine.LFD.2.20.1511171155240.5826@knanqh.ubzr>
 <HK2PR06MB0561B7675F17A81B54A65CA28A1C0@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <alpine.LFD.2.20.1511172129060.22569@knanqh.ubzr>
Message-ID: <HK2PR06MB0561077CA74074E175561D7F8A1C0@HK2PR06MB0561.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> With XIP there is still an init section, [snip]
> No need to page align it either at that point which should save some
> ROM space.

Good point.

> Things like .kprobes.text should be in ROM, [snip]
>
> Etc. Etc.

Here's the thing...I'm probably out of my depth on most of this. But, I'd be happy to post up a RFC patch and then start collecting the feedback on what can be removed. I can at least test it on a real XIP system.


Chris
