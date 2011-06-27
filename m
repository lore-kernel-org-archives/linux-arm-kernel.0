From: jszhang3@gmail.com (JiSheng Zhang)
Date: Mon, 27 Jun 2011 18:14:13 +0800
Subject: how to suspend on arm smp platform
Message-ID: <BANLkTimYxi2rUwp+pkRxNWAXKhob7AJHmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi List,

I need your help about suspend on SMP.

I notice that there's some smp support code in
arch/arm/kernel/sleep.S. cpu hotplug code is similar as realview
platform--just put the non-boot cpu into WFI state. So how do non-boot
cpu resume back to the hotplug code path? If resume doesn't make use
of the hotplug, then how to resume non-boot cpus? Currently, UP kernel
suspend works perfectly on my SoC, I need your help about SMP suspend.

PS: all cpus power are put together, so on my soc cpu hotplug code can
only put the non-boot cpus into WFI state.

Thanks in advance,
Jisheng
