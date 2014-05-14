From: tony@atomide.com (Tony Lindgren)
Date: Wed, 14 May 2014 14:45:35 -0700
Subject: [PATCH] ARM: dts: AM33XX: fix ethernet and mdio default state
In-Reply-To: <1399539456-555-1-git-send-email-jhovold@gmail.com>
References: <1399539456-555-1-git-send-email-jhovold@gmail.com>
Message-ID: <20140514214534.GK27426@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Johan Hovold <jhovold@gmail.com> [140508 01:59]:
> Make sure ethernet and mdio nodes are disabled by default and enable
> them explicitly only on boards that actually use them.

Thanks applying into omap-for-v3.16/dt.

Tony
