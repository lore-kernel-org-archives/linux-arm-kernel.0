From: horms@verge.net.au (Simon Horman)
Date: Wed, 5 Jul 2017 11:24:32 +0100
Subject: [PATCH v2] ARM: debug-ll: Add support for r8a7743
In-Reply-To: <1496916494-19725-1-git-send-email-chris.paterson2@renesas.com>
References: <1496908117-19368-1-git-send-email-chris.paterson2@renesas.com>
 <1496916494-19725-1-git-send-email-chris.paterson2@renesas.com>
Message-ID: <20170705102432.GB24043@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 08, 2017 at 11:08:14AM +0100, Chris Paterson wrote:
> Enable low-level debugging support for RZ/G1M (r8a7743). RZ/G1M uses
> SCIF0 for the debug console, like most of the R-Car Gen2 SoCs.
> 
> Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, applied for v4.14.
