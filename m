From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Wed, 18 Nov 2015 20:00:05 +0000
Subject: [PATCH v3] ARM: xip: Use correct symbol for end of ROM marker
In-Reply-To: <alpine.LFD.2.20.1511181437030.22569@knanqh.ubzr>
References: <1447362108-4333-1-git-send-email-chris.brandt@renesas.com>
 <1447697140-4099-1-git-send-email-chris.brandt@renesas.com>
 <alpine.LFD.2.20.1511161515100.5826@knanqh.ubzr>
 <HK2PR06MB05619FACB3725B6F5B2299718A1E0@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <alpine.LFD.2.20.1511161605070.5826@knanqh.ubzr>
 <HK2PR06MB056196B2E169A504A16ED9738A1D0@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <alpine.LFD.2.20.1511171155240.5826@knanqh.ubzr>
 <HK2PR06MB0561B7675F17A81B54A65CA28A1C0@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <alpine.LFD.2.20.1511172129060.22569@knanqh.ubzr>
 <HK2PR06MB0561077CA74074E175561D7F8A1C0@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <alpine.LFD.2.20.1511181204240.22569@knanqh.ubzr>
 <HK2PR06MB0561BAC75F605C9C51966B948A1C0@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <alpine.LFD.2.20.1511181437030.22569@knanqh.ubzr>
Message-ID: <HK2PR06MB0561A83E36C90DA0E29FC3478A1C0@HK2PR06MB0561.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> Are you saying I should first submit a patch that simply adds the
>> new file, but not hook it up to any Makefiles yet?
>> Then, once it has been updated a few times and is in better shape,
>> I submit another patch that hooks it up with the Makefiles so I can
>> then finally remove the XIP_KERNEL parts from the current
>> vmlinux.lds.S?
>
> Well... I'm of the opinion now that the first patch should be the
> creation of the new script being a copy of the original with the
> XIP conditionals removed from both, plus the makefile changes. That
> should be easy to verify that nothing changed result wise, and then
> additional patches could bring XIP efinements on top without
> disturbing the non-XIP case.
>
> Nicolas

OK. I'm good with that. I'll submit a patch and see what happens.

Chris
