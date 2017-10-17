From: horms@verge.net.au (Simon Horman)
Date: Tue, 17 Oct 2017 10:02:20 +0200
Subject: [PATCH 3/4] ARM: dts: iwg22d-sodimm-dbhd-ca: Add device tree for
 HDMI DB
In-Reply-To: <1507899796-7941-4-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1507899796-7941-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1507899796-7941-4-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <20171017080220.ff5brg2jh4womfj2@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 13, 2017 at 02:03:15PM +0100, Fabrizio Castro wrote:
> Add file r8a7745-iwg22d-sodimm-dbhd-ca.dts to provide support for
> iW-RainboW-G22D with HDMI daughter board plugged in.
> 
> The interfaces defined in the new .dts file are: scif1, scif5,
> and hscif2.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>

I wonder if this patch should include a chosen node.
