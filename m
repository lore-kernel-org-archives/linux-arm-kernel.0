From: afzal@ti.com (Mohammed, Afzal)
Date: Mon, 27 Aug 2012 11:46:02 +0000
Subject: [PATCH v6 07/10] ARM: OMAP2+: gpmc: generic timing calculation
In-Reply-To: <20120824195446.GV11011@atomide.com>
References: <cover.1345524670.git.afzal@ti.com>
 <83b963e4ebcc1009a26a8c6419c785ac6d742c0b.1345524670.git.afzal@ti.com>
 <50359C64.40603@ti.com> <20120824195446.GV11011@atomide.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9BA684@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Sat, Aug 25, 2012 at 01:24:47, Tony Lindgren wrote:

> Yes agreed. Also as some values make sense only in cycles, converting them
> back and forth to time is wrong. So at least some values should have an
> option to specify them in cycles directly, and then ignore any time based
> values.

Which values in struct gpmc_device_timings are you referring to ?

Values that need to have an option to specify in cycles has been provided
such an option, while not updating time based field value, you can
achieve what you mentioned above. But if you want that to be handled in
in generic routine, I will do so.

Regards
Afzal
