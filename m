From: olof@lixom.net (Olof Johansson)
Date: Mon, 12 Jan 2015 14:34:15 -0800
Subject: [GIT PULL] Renesas ARM Based SoC sh73a0 CCF Updates for v3.20
In-Reply-To: <cover.1419809955.git.horms+renesas@verge.net.au>
References: <cover.1419809955.git.horms+renesas@verge.net.au>
Message-ID: <20150112223415.GJ22090@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 29, 2014 at 10:46:58AM +0900, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM based SoC sh73a0 CCF updates for v3.20.
> 
> 
> The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:
> 
>   Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-sh73a0-ccf-for-v3.20
> 
> for you to fetch changes up to 09bd745b555c262d1e2c851777317f3adf3cf3d4:
> 
>   ARM: shmobile: sh73a0: disable legacy clock initialization (2014-12-21 17:09:25 +0900)

This could really have been sliced slightly differently with the drivers/clk
change going in a drivers branch, but that might be a bit too messy given that
this is better done as a mostly-atomic switch over.

I've merged this into next/drivers as a whole now. Please be careful with
conflicts against this branch with other new additions this cycle.


-Olof
