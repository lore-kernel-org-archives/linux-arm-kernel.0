From: tony@atomide.com (Tony Lindgren)
Date: Mon, 5 Mar 2012 11:55:18 -0800
Subject: [PATCH V3 2/2] mcx: support for HTKW mcx board
In-Reply-To: <1324482822-24221-3-git-send-email-yanok@emcraft.com>
References: <1324482822-24221-1-git-send-email-yanok@emcraft.com>
 <1324482822-24221-3-git-send-email-yanok@emcraft.com>
Message-ID: <20120305195518.GQ12083@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ilya Yanok <yanok@emcraft.com> [111221 07:21]:
> Support for the HTKW mcx board (TI AM3517 based) including serial,
> Ethernet, I2C, USB host, HSMMC, DSS and RTC.

This one I can carry in testing-board until device tree works
for us in a usable way. But probably some rebasing is needed
for this after the hsmmc stuff is cleared out of the way.

Regards,

Tony
