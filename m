From: will.deacon@arm.com (Will Deacon)
Date: Tue, 24 Jan 2012 16:13:33 +0000
Subject: [PATCH 22/31] ARM: amba: integrator: use common amba device
 initializers
In-Reply-To: <E1RoAn8-0005Fk-Hc@rmk-PC.arm.linux.org.uk>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk>
 <E1RoAn8-0005Fk-Hc@rmk-PC.arm.linux.org.uk>
Message-ID: <20120124161332.GN19798@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2012 at 09:29:50AM +0000, Russell King - ARM Linux wrote:
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/mach-integrator/core.c          |   70 ++++++------------------------
>  arch/arm/mach-integrator/integrator_cp.c |   49 ++++-----------------
>  2 files changed, 22 insertions(+), 97 deletions(-)

Seems happy enough on my Integrator-CP w/ 1136 core tile.

Tested-by: Will Deacon <will.deacon@arm.com>

Will
