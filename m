From: jochen@scram.de (Jochen Friedrich)
Date: Wed, 03 Aug 2011 18:02:49 +0200
Subject: [PATCH 01/17] leds: create a trigger for CPU activity
In-Reply-To: <20110803153035.GL2607@pulham.picochip.com>
References: <1312364089-32380-1-git-send-email-bryan.wu@canonical.com>
	<1312364089-32380-2-git-send-email-bryan.wu@canonical.com>
	<20110803102829.GC2607@pulham.picochip.com>
	<CACRpkdZRh=gcedJQh6V3aUCfi2arn2V_P67MgZE2mB_hYZ-OnQ@mail.gmail.com>
	<20110803153035.GL2607@pulham.picochip.com>
Message-ID: <4E397129.2000801@scram.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jamie,

> I understand that bit, but I can't see anything that actually assigns
> led->trigger_data in the first place.

I just tested this on simpad and while I can assign the cpu trigger to 
the green LED using the sys fs, the trigger just sits there and does 
nothing, just like the "none" trigger.

Thanks,
Jochen
