From: davem@davemloft.net (David Miller)
Date: Wed, 12 Feb 2014 19:18:46 -0500 (EST)
Subject: [PATCH 0/14] Xilinx axi ethernet patches
In-Reply-To: <cover.1392220536.git.michal.simek@xilinx.com>
References: <cover.1392220536.git.michal.simek@xilinx.com>
Message-ID: <20140212.191846.1464564509609498703.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Michal Simek <michal.simek@xilinx.com>
Date: Wed, 12 Feb 2014 16:55:34 +0100

> I have exctracted patches which I have in our
> xilinx git tree which are missing in the mainline.
> 
> The first two patches fix compilation error and
> warnings. Then 5 feature patches
> and the rest is OF cleanup and with kernel-doc
> and checkpatch problems.

You should not combine bug fix and feature patches.

Rather, you should submit bug fixes against the 'net' tree.  Then when
those bug fixes get applied and propagate to the 'net-next' tree you
can submit the feature patches and cleanups against the 'net-next'
tree.
