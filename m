From: horms@verge.net.au (Simon Horman)
Date: Fri, 15 Sep 2017 09:54:15 +0200
Subject: [PATCH 2/8] ARM: dts: r8a7745: Add SDHI controllers
In-Reply-To: <1505322341-9480-3-git-send-email-chris.paterson2@renesas.com>
References: <1505322341-9480-1-git-send-email-chris.paterson2@renesas.com>
 <1505322341-9480-3-git-send-email-chris.paterson2@renesas.com>
Message-ID: <20170915075415.GG3924@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 13, 2017 at 06:05:35PM +0100, Chris Paterson wrote:
> From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> 
> Add the SDHI controllers to the r8a7745 device tree.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>

Thanks, applied.

> ---
> This patch is based on renesas-devel-20170913-v4.13.
> 
> This patch is dependant on:
> - "dt-bindings: mmc: sh_mmcif: Document r8a7745 DT bindings"

I think that should be "[PATCH v3] mmc: renesas_sdhi: Add r8a7743/5 support"
