From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat, 12 Sep 2015 13:23:35 -0700
Subject: [PATCH 4/7] soc: brcmstb: add PM suspend/resume support (S2/S3/S5)
In-Reply-To: <1434672696-13632-5-git-send-email-computersforpeace@gmail.com>
References: <1434672696-13632-1-git-send-email-computersforpeace@gmail.com>
 <1434672696-13632-5-git-send-email-computersforpeace@gmail.com>
Message-ID: <55F489C7.4010007@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 06/18/15 17:11, Brian Norris a ?crit :
> Support S2, S3, and S5 through /sys/power/state ("standby" and "mem")
> and the poweroff code paths. See comments in pm.c for a few more details
> about these system suspend modes.
> 
> Signed-off-by: Brian Norris <computersforpeace@gmail.com>

Applied to soc/next with an appropriate AFLAGS to force the assembler in
ARMv7-a mode for s2.S, thanks!
-- 
Florian
