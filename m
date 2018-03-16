From: horms@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 17:25:20 +0100
Subject: [PATCH 42/52] ARM: dts: r7s72100: add USB device to device tree
In-Reply-To: <TY1PR01MB1562ED183D137FA48FCBC7DB8AD70@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <cover.1521208546.git.horms+renesas@verge.net.au>
 <faa6c0071114fd433e83dddd3a42fba547ca9a67.1521208546.git.horms+renesas@verge.net.au>
 <TY1PR01MB1562ED183D137FA48FCBC7DB8AD70@TY1PR01MB1562.jpnprd01.prod.outlook.com>
Message-ID: <20180316162516.6qidilshycg7lg2n@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 16, 2018 at 03:02:13PM +0000, Chris Brandt wrote:
> Hi Simon,
> 
> On Friday, March 16, 2018 1, Simon Horman wrote:
> > From: Chris Brandt <chris.brandt@renesas.com>
> > 
> > Add USB device support.
> > 
> > Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> This patch is already in mainline:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8a99b6ad4da2f90969bb2ebb426c1d3dd0089fa4
> 
> Pushed by Greg.
> 
> At one point Greg applied it, then reverted it (as requested by Geert), 
> but then somehow it still went in.

Ok, that is a bit unfortunate.

I'll repost with that patch and the cleanup patches that depend on it
dropped.
