From: tony@atomide.com (Tony Lindgren)
Date: Mon, 5 Mar 2012 14:12:47 -0800
Subject: [PATCH] arch/arm/plat-omap/clock.c: included linux/debugfs.h twice
In-Reply-To: <1329403433-32327-1-git-send-email-danny.kukawka@bisect.de>
References: <1329403433-32327-1-git-send-email-danny.kukawka@bisect.de>
Message-ID: <20120305221247.GZ12083@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Danny Kukawka <danny.kukawka@bisect.de> [120216 06:12]:
> arch/arm/plat-omap/clock.c: included 'linux/debugfs.h' twice,
> remove the duplicate.

Thanks, applying into fixes-non-critical-part2.

Regards,

Tony
