From: a.j.buxton@gmail.com (Alistair Buxton)
Date: Thu, 15 Oct 2009 01:12:52 +0100
Subject: [PATCH 00/17] Massive OMAP730/OMAP850 cleanup
In-Reply-To: <20091014211206.GL12700@atomide.com>
References: <3d374d00910141250h22e18bccpa6792d2a323b61f8@mail.gmail.com>
	<20091014211206.GL12700@atomide.com>
Message-ID: <3d374d00910141712o6db73c8ejf2e49e4a65b758d6@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2009/10/14 Tony Lindgren <tony@atomide.com>:
> * Alistair Buxton <a.j.buxton@gmail.com> [091014 13:03]:
>> Reposting the full series for review. Assuming this is all OK would it
>> be a good idea to merge the config variables into a single
>> CONFIG_ARCH_OMAP7XX? There doesn't seem to be any reason to have both.
>> Original description follows.
>
> Yeah, those should be merged too. Let's do that as a separate patch.

On a related note, the omap850.h and omap730.h should go away too,
when everyone is happy with the new omap7xx.h. Perhaps we should add a
#warning to them so people know they will be removed at some point?

-- 
Alistair Buxton
a.j.buxton at gmail.com
