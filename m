From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 21 Jul 2014 14:38:13 +0200
Subject: [PATCHv2 12/17] cpuidle: mvebu: make the cpuidle driver capable
 of handling multiple SoCs
In-Reply-To: <53CD08CF.6080900@linaro.org>
References: <1404913221-17343-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <52019695.n2AjkGEsJ7@wuerfel>
 <20140721133534.3415e425@free-electrons.com>
 <5251405.VTrfDi1rj5@wuerfel>
 <20140721140917.16e71558@free-electrons.com>
 <53CD08CF.6080900@linaro.org>
Message-ID: <20140721143813.6028b6ed@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Daniel Lezcano,

On Mon, 21 Jul 2014 14:34:23 +0200, Daniel Lezcano wrote:

> So there are three solutions:
> 
> 1. Pass the flag through the platform data, I am not really in favor of 
> that as mentioned above

That's what is already implemented.

> 
> 2. Use the compatible string like the cpuidle-big-little.c driver, but 
> Arnd is not in favor of that
> 
> 3. Register 3 platform drivers, in cpuidle-mvebu-v7.c, and let the 
> registering of the cpuidle's platform device to enable the right one

I'm fine with doing (3). Daniel, Arnd, let me know if that's ok for
you, and I'll respin the patch series accordingly.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
