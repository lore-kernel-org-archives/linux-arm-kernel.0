From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 15 May 2013 14:36:40 +0200
Subject: v3.10-rc1: compile problem in arch/arm/common/mcpm_platsmp.c
Message-ID: <20130515123640.GA9066@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

I'm trying to switch to v3.10-rc1, and got following:

arch/arm/common/mcpm_platsmp.c: In function 'mcpm_secondary_init':
arch/arm/common/mcpm_platsmp.c:52:2: error: implicit declaration of
function 'gic_secondary_init' [-Werror=implicit-function-declaration]
cc1: some warnings being treated as errors
make[1]: *** [arch/arm/common/mcpm_platsmp.o] Error 1
make: *** [arch/arm/common] Error 2
make: *** Waiting for unfinished jobs....

I do have 

CONFIG_ARM_GIC=y

.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
