From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 11 Jun 2014 14:07:40 +0200
Subject: mvebu: build error in -next
In-Reply-To: <20140609185550.GA5034@arch.cereza>
References: <20140609185550.GA5034@arch.cereza>
Message-ID: <20140611140740.1bbe4a94@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ezequiel Garcia,

On Mon, 9 Jun 2014 15:55:50 -0300, Ezequiel Garcia wrote:

> It seems we have a build error in latest -next (20140606):
> 
> arch/arm/mach-mvebu/built-in.o: In function `armada_370_xp_cpu_resume':
> /home/zeta/fast/linux/next/arch/arm/mach-mvebu/pmsu.c:145: undefined reference to `cpu_resume'
> arch/arm/mach-mvebu/built-in.o: In function `armada_370_xp_cpu_suspend':
> /home/zeta/fast/linux/next/arch/arm/mach-mvebu/pmsu.c:223: undefined reference to `cpu_suspend'
> 
> Find the config is enclosed; it's probably just a few ifdef's to add.

Thanks for reporting this, I've just sent a patch to fix it.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
