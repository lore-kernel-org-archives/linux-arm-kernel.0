From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Thu, 3 Feb 2011 14:04:01 +0200
Subject: PXA270 Random Hangs at Low Core Freq
In-Reply-To: <A6E7D305-39A1-42B3-8A2B-0D2CDBBE5EEE@prograde.net>
References: <471CD45F-4531-4C87-B292-411CE519D0A5@prograde.net>
	<AANLkTi=Y-JYQ_eZ4EdNirPrm_xkiduSZP19BPWckP2iW@mail.gmail.com>
	<A6E7D305-39A1-42B3-8A2B-0D2CDBBE5EEE@prograde.net>
Message-ID: <201102031404.02387.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 26 October 2010 20:06:36 Michael Cashwell wrote:

> Voltage slewing is an area I had been working on. The TPS65023 driver has
> some problems (like failing to actually command a voltage change!). I'm
> going to submit patches for this but it's not involved in the problem it's
> disabled in my kernel config. The Verdex Pro PMIC is strapped to come out
> of reset at a core voltage of 1.55VDC (verified on a scope). That's high
> enough to support all core speeds.

Hi, Michael, can you share your patches for TPS65023?

Regards
Vasily
