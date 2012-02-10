From: tony@atomide.com (Tony Lindgren)
Date: Fri, 10 Feb 2012 09:40:47 -0800
Subject: [PATCH] omap: board-omap3evm: add required smsc911x regulators
In-Reply-To: <1328738812-26755-1-git-send-email-mporter@ti.com>
References: <1328738812-26755-1-git-send-email-mporter@ti.com>
Message-ID: <20120210174046.GQ1426@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Matt Porter <matt@ohporter.com> [120208 13:35]:
> This fixes smsc911x support on omap3evm that has been broken since
> the smsc911x driver was updated to require the existence of vdd33a
> and vddvario supplies.

Great. Few comments:

1. Could you please include the smsc911x commit and subject here too
   so it clearly shows the regression?

2. Also, why don't you add this fixed regulator to gpmc-smsc911.c?

That way it gets fixed for other too, like zoom2/3.

Regards,

Tony
