From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 9 Jan 2012 13:13:31 +0100
Subject: [PATCH] ARM: PXA: Zipit Z2: Fix oops in z2_power_off
In-Reply-To: <CA+E=qVcYsa487rSAa48ZrJU64f1z1bbNXgjDnq23Y45WqwiXMg@mail.gmail.com>
References: <1326011616-3546-1-git-send-email-anarsoul@gmail.com>
 <201201090058.44041.marek.vasut@gmail.com>
 <CA+E=qVcYsa487rSAa48ZrJU64f1z1bbNXgjDnq23Y45WqwiXMg@mail.gmail.com>
Message-ID: <201201091313.31535.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 2012/1/9 Marek Vasut <marek.vasut@gmail.com>:
> >> Nope, it does not work. Looks like device disables power on memory in
> >> deepsleep.
> > 
> > Why?
> 
> In deepsleep PXA27x deasserts SYS_EN pin, and looks like when it's
> deasserted there's no power on SDRAM (on Zipit). Just guess.

Then maybe implement suspend-to-disk ? There was a patch for omap on the list, 
maybe it's even merged.

M
