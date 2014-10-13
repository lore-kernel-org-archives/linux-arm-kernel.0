From: viric@viric.name (=?iso-8859-1?Q?Llu=EDs?= Batlle i Rossell)
Date: Mon, 13 Oct 2014 12:52:46 +0200
Subject: Regarding tx-nocache-copy in the Sheevaplug
Message-ID: <20141013105246.GD1972@vicerveza.homeunix.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

on the 7th of January 2014 ths patch was applied:
https://lkml.org/lkml/2014/1/7/307

[PATCH v2] net: Do not enable tx-nocache-copy by default
        
In the Sheevaplug (ARM Feroceon 88FR131 from Marvell) this made packets to be
sent corrupted. I think this machine has something special about the cache.

Enabling back this tx-nocache-copy (as it used to be before the patch) the
transfers work fine again. I think that most people, encountering this problem,
completely disable the tx offload instead of enabling back this setting.

Is this an ARM kernel problem regarding this platform?

Thank you,
Llu?s
