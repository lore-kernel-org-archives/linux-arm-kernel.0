From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 3 Sep 2013 13:45:46 +0200
Subject: [PULL REQUEST] big-endian updates for ARM
In-Reply-To: <5225C714.3090504@codethink.co.uk>
References: <20130903101332.GA26613@localhost.localdomain>
 <5225C714.3090504@codethink.co.uk>
Message-ID: <20130903134546.5240306b@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ben Dooks,

On Tue, 03 Sep 2013 12:25:08 +0100, Ben Dooks wrote:

> Sorry, I thought that had been fixed, thanks for reminding me.
> 
> I have fixed it and now on:
> 
> 	git://git.baserock.org/delta/linux baserock/311-rc7/be/core-v4

Can you resend a proper pull request for this core-v4 branch? There has
been two fixes since the v3, the Acked-by from one of the mach-mvebu
maintainers, and my Tested-by.

Also, as indicated on IRC, I confirm that this patch set also works on
Armada 370. It doesn't work on one particular Armada 370 board that I
have, but it's using an old bootloader that may be the cause of the
issue. The BE kernel works fine on the two other Armada 370 boards I've
tested.

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
