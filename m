From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 2 Sep 2011 14:47:18 -0400 (EDT)
Subject: testing-board branch: rebase to RMK's devel-stable?
In-Reply-To: <87vcta7r9f.fsf@ti.com>
References: <87vcta7r9f.fsf@ti.com>
Message-ID: <alpine.LFD.2.00.1109021446300.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2 Sep 2011, Kevin Hilman wrote:

> Hi Tony,
> 
> Your testing-board branch currently has a couple new boards that are
> missing the boot_params to atag_offset conversion (patch below.)
> 
> There's a patch below to fix this, but maybe it's better to just rebase
> your testing-board branch onto Russell's devel-stable branch (where he's
> merged the seris from Nico) so any board stuff we add is sure to do it
> correctly.

I would suggest that too.


Nicolas
