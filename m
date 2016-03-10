From: tony@atomide.com (Tony Lindgren)
Date: Thu, 10 Mar 2016 10:07:45 -0800
Subject: Tons of "no unit name" spam with make dtbs
Message-ID: <20160310180745.GD9329@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Rob,

I'm seeing tons of dtc spam with make dtbs (about 23k lines
with multi_v7_defconfig!) with commit fa38a82096a1 ("scripts/dtc:
Update to upstream version 53bf130b1cdd").

Introducing something like this few days with merge window
about to open seems to be in the "a bit intrusive" category
to me :)

Probably some of these changes should be reverted?

Regards,

Tony
