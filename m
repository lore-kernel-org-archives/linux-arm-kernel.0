From: horms@verge.net.au (Simon Horman)
Date: Fri, 15 Sep 2017 09:45:51 +0200
Subject: [PATCH 1/8] ARM: dts: r8a7745: Add APMU node and second CPU core
In-Reply-To: <1505322341-9480-2-git-send-email-chris.paterson2@renesas.com>
References: <1505322341-9480-1-git-send-email-chris.paterson2@renesas.com>
 <1505322341-9480-2-git-send-email-chris.paterson2@renesas.com>
Message-ID: <20170915074551.GF3924@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Cc Geert]

On Wed, Sep 13, 2017 at 06:05:34PM +0100, Chris Paterson wrote:
> From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> 
> Add DT node for the Advanced Power Management Unit (APMU), add the
> second CPU core, and use "renesas,apmu" as "enable-method".
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
> ---
> This patch is based on renesas-devel-20170913-v4.13.

Hi,

with reference to "[PATCH v3 0/3] ARM: renesas: Enable SMP on R-Car E2"
is the CNTVOFF initialised in the boot loader of boards (in upstream)
for this SoC? If not I expect you will have trouble with the arch timer
on secondary CPU cores.

The patch itself looks good to me.
