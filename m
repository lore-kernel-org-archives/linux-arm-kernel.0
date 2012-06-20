From: tony@atomide.com (Tony Lindgren)
Date: Wed, 20 Jun 2012 03:17:17 -0700
Subject: [RFC PATCH v2 02/11] ARM: OMAP: expose control.h to mach area
In-Reply-To: <4FDF11C0.4090908@dev.rtsoft.ru>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
 <4FDF11C0.4090908@dev.rtsoft.ru>
Message-ID: <20120620101716.GY12766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Konstantin Baydarov <kbaidarov@dev.rtsoft.ru> [120618 04:36]:
> This patch exposes the definitions under control.h to
> drivers outside the machine code.

As discussed earlier, this will likely lead into misuse of these
registers that will be a big mess to clean up.

Can't you make these private to the driver(s)?

Tony
