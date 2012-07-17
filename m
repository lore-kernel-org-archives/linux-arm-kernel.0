From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 17 Jul 2012 14:01:00 +0200
Subject: Device tree.
In-Reply-To: <500552C9.4090107@codethink.co.uk>
References: <500552C9.4090107@codethink.co.uk>
Message-ID: <20120717140100.7c0ae90c@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Tue, 17 Jul 2012 12:55:53 +0100,
Ian Molton <ian.molton@codethink.co.uk> a ?crit :

> I've found some references to this in the mailinglist archives but 
> nothing conclusive.
> 
> Whats the recommended way of dealing with devicetree when one is
> stuck with an unco-operative bootloader?
> 
> I've made a small hack (below) to allow me to append a .dtb to the
> end of the kernel image. I note that other similar hacks have not
> been picked up, but I can't see why. Or I've missed the one that did
> get chosen.

You surely want to have a look at CONFIG_ARM_APPENDED_DTB, which does
what you want and is already part of the ARM kernel.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
