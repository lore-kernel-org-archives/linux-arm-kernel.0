From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 8 Sep 2011 22:18:13 +0200
Subject: [PATCH 3/4] mach-integrator: modernize clock event registration
In-Reply-To: <20110908085502.GB14953@n2100.arm.linux.org.uk>
References: <1315384260-27404-1-git-send-email-linus.walleij@stericsson.com>
	<alpine.LFD.2.02.1109071202000.2723@ionos>
	<20110908085502.GB14953@n2100.arm.linux.org.uk>
Message-ID: <CAKnu2MqVY0k2OdAC3awtQ-ry7hmqPHC9ttTbx8nsG7iuVJu=dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/9/8 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> My understanding is that periodic timers are not setup by the generic
> clock event code, and so we do need to keep the 'timer_reload' stuff
> around. ?Note that patch 2 deletes the register write for this too,
> so you actually have one logical change split across patch 2 and 3.

I've fixed this up in v2 (hopefully) and I'll update the patches
2 thru 4 to the new versions in the patch system.

Thanks Russell!
Linus Walleij
