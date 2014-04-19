From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 19 Apr 2014 18:45:56 +0200
Subject: [PATCH 1/2] ARM: mvebu: remove unnecessary ifdef around
 l2x0_of_init
In-Reply-To: <1397925170-8202-2-git-send-email-gregory.clement@free-electrons.com>
References: <1397925170-8202-1-git-send-email-gregory.clement@free-electrons.com>
 <1397925170-8202-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20140419184556.0924f14d@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gregory CLEMENT,

On Sat, 19 Apr 2014 18:32:49 +0200, Gregory CLEMENT wrote:
> l2x0_of_init function is always defined
> arch/arm/include/asm/hardware/cache-l2x0.h: in case of
> CONFIG_CACHE_L2X0 is not selected then a placeholder is defined.
> Then there is no need to have ifdef around  l2x0_of_init.

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
