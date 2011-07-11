From: jochen@scram.de (Jochen Friedrich)
Date: Mon, 11 Jul 2011 10:28:54 +0200
Subject: [PATCH 16/17] mach-sa1100: retire custom LED code
In-Reply-To: <20110710092426.GR4812@n2100.arm.linux.org.uk>
References: <1309955687-19365-1-git-send-email-bryan.wu@canonical.com>	<1309955687-19365-17-git-send-email-bryan.wu@canonical.com>
	<20110710092426.GR4812@n2100.arm.linux.org.uk>
Message-ID: <4E1AB446.4000903@scram.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

>> +fs_initcall(simpad_leds_init);
>
> Looks like simpad is similarly afflicted.  I haven't gone through the
> rest to check for similar issues.

simpad is buggy in other means, as well (wrong bit, read of write-only 
register, missing locking). That's why I want to push my CS3 cleanup 
patch first, converting a custom IO to standard GPIO ;-)

Thanks,
Jochen
