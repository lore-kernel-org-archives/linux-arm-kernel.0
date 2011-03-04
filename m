From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 04 Mar 2011 19:14:49 +0300
Subject: [PATCH] ARM: mx51_efika: update platform data for new mfd changes
In-Reply-To: <20110304080653.3f2c3f19@debxo>
References: <20110304080653.3f2c3f19@debxo>
Message-ID: <4D710FF9.6040305@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Andres Salomon wrote:

> Note that this relies on stuff currently in mfd's next tree, but this
> is also a newer driver.  I'm not sure which tree it should go through,
> as it's a problem that shows up in next.

    This passage should be under --- tear line.

> From: Andres Salomon <dilinger@queued.net>

> MFD changes in c738892f cause the mc13xxx_platform_data struct

    Linus asks to also specify the commit summary in parens.

> to change.  This changes one more (new) user of it, fixing a build
> error.

> Signed-off-by: Andres Salomon <dilinger@queued.net>

WBR, Sergei
