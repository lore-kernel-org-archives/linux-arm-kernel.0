From: tony@atomide.com (Tony Lindgren)
Date: Thu, 9 May 2013 11:45:48 -0700
Subject: [PATCHv2] ARM:dts:omap4-panda:Update the LED support for the
 panda DTS
In-Reply-To: <518BE617.1080509@ti.com>
References: <1366229760-4808-1-git-send-email-dmurphy@ti.com>
 <516FBD18.3060501@ti.com> <51703BEF.6050804@ti.com>
 <20130508234745.GV32546@atomide.com> <518BE617.1080509@ti.com>
Message-ID: <20130509184548.GH31554@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Dan Murphy <dmurphy@ti.com> [130509 11:13]:
>
> Can we cleanly append to omap4_pmx_core without overriding the whole node?
> I don't want to recreate the pmx_core node in the es file.

Yes that should work just fine.

Regards,

Tony
