From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 20 Mar 2015 10:38:56 +0000
Subject: Arm SP804 module compilation for arm64
In-Reply-To: <1245841569.555427.1426844135905.JavaMail.yahoo@mail.yahoo.com>
References: <1245841569.555427.1426844135905.JavaMail.yahoo@mail.yahoo.com>
Message-ID: <550BF8C0.3010108@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/03/15 09:35, Hari vyas wrote:
> Hi!
> I am able to see arch/arm/common/timer-sp.c but same is not available
> in arch/arm64.
> 
> I believe, it should be made available in driver/clocksource for ARCH=arm64
> compilation perspective.
> Please check and advice accordingly

Indeed. Feel free to submit a patch series converting it to something
more generic.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
