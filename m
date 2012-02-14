From: tony@atomide.com (Tony Lindgren)
Date: Tue, 14 Feb 2012 11:52:50 -0800
Subject: [PATCH 1/4] ARM: OMAP2+: board-generic: Remove un-needed
 .atag_offset for DT_MACHINE
In-Reply-To: <1329150625-8604-2-git-send-email-b-cousson@ti.com>
References: <1329150625-8604-2-git-send-email-b-cousson@ti.com>
Message-ID: <20120214195249.GS1426@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Benoit Cousson <b-cousson@ti.com> [120213 07:59]:
> Some .atag_offset entries were wrongly added during a merge conflict
> resolution in 3.3.
> Remove them all, since DT boot does not use that attribute anymore.
> 
> Replace as well the #if... by #ifdef for consistency.

How about let's also remove the 0x from the serial at 0x.. in the .dts
files in this clean-up patch?

Regards,

Tony
