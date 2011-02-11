From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 11 Feb 2011 19:07:44 +0100
Subject: [PATCH/RFC] ARM: S5P: Add platform helpers for camera GPIO
	configuration
Message-ID: <1297447665-19492-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

the following patch introduces platform helpers for the peripheral 
parallel camera bus configuration in S5PV210 and S5PV310 SoCs.
In those SoCs multiple camera host interface IP's are available and
can be attached to any of two ITU-R parrallel bus for external sensor.
That's why I didn't try to pass any platform device as a pointer to those
helpers. This is an initial proposal and any comments are appreciated.


[PATCH] ARM: S5P: Add platform helpers for camera GPIO configuration

Created against for-next branch at:
git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 


Regards,
--
Sylwester Nawrocki
Samsung Poland R&D Center
