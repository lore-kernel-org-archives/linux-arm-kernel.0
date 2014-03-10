From: davem@davemloft.net (David Miller)
Date: Sun, 09 Mar 2014 20:30:01 -0400 (EDT)
Subject: [PATCH] net: phy: Add sysfs attribute to prevent PHY suspend
In-Reply-To: <531CF864.9040406@gmail.com>
References: <1394192092-27461-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20140309.191235.1047481546773873653.davem@davemloft.net>
 <531CF864.9040406@gmail.com>
Message-ID: <20140309.203001.1318893833441564547.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Date: Mon, 10 Mar 2014 00:25:24 +0100

> There is no way to determine if a bootloader is broken or not. The
> sysfs knob allows to provide a use case based decision. Of course,
> we can invent some freaky device tree property but that the DT
> maintainers will not like either.

My point is that whatever mechanism is used to "decide" that the sysfs
knob gets set, can also be used to "decide" that a DT property is
instantiated in the device tree.
