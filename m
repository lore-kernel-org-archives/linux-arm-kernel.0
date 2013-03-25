From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 25 Mar 2013 07:45:14 -0300
Subject: [PATCH v2 00/14] Marvell EBU thermal sensor consolidation
In-Reply-To: <20130325093001.GH5627@lunn.ch>
References: <1363991114-4225-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130325093001.GH5627@lunn.ch>
Message-ID: <20130325104513.GC2502@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 25, 2013 at 10:30:01AM +0100, Andrew Lunn wrote:
[...]
> 
> What does all this mean? I _think_ there will be less and less shared
> code in future as these extra features are added.
> 

Yes, I see your point. On the other side, I don't like the idea of
taking this decision based in the uncertain science of futurology :)

When will we add this extra features? Will we add them at all?

> I've not a strong opinion, but i think separate drivers are better. 
> 

Don't you think a single driver could make maintenance cheaper?

> If we do stick to one driver, i would however want #ifdef
> CONFIG_ARCH_DOVE, CONFIG_ARCH_KIRKWOOD, CONFIG_MACH_ARMADA_XP &
> CONFIG_MACH_ARMADA_370 scattered through the code.
> 

Mmm... I'm not a fan for ifdefs. Actually, I really *hate* ifdefs.
I'll try to come up with an ifdef solution without making it too nasty.

Otherwise, perhaps I'll send a patch for Armada 370/XP only; I don't
want to push harder on something I'm not *absolutely* sure about either.
If we see there's an opportunity to merge the drivers, we can do always
do that later.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
