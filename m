From: linux-kernel.bfrz@manchmal.in-ulm.de (Christoph Biedl)
Date: Thu, 6 Sep 2012 09:10:41 +0200
Subject: Dockstar fails to boot since v3.0-rc6-6-g3835d69
In-Reply-To: <20120906054034.GA28549@lunn.ch>
References: <20120906054034.GA28549@lunn.ch>
Message-ID: <1346915288@msgid.manchmal.in-ulm.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew Lunn wrote...

> You kernel config does seem likely, so lets try playing with that.
> 
> Please could you try a kirkwood_defconfig.

Ah, should have thought of that, thanks. Comparing .config and playing
suggests that disabling CONFIG_ARM_PATCH_PHYS_VIRT is a least a
workaround. Anything more I can test?

    Christoph
