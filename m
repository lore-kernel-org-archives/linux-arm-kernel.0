From: broonie@kernel.org (Mark Brown)
Date: Wed, 19 Feb 2014 22:59:38 +0900
Subject: [RFC PATCH v2 1/2] mfd: syscon: Support early initialization
In-Reply-To: <5304B6E8.1090508@monstr.eu>
References: <cover.1392807832.git.michal.simek@xilinx.com>
 <fa3178534fcf4488fc45a9a24e44b2588acb38c6.1392807832.git.michal.simek@xilinx.com>
 <20140219114132.GC10504@lee--X1> <53049932.8020901@monstr.eu>
 <20140219121756.GM2669@sirena.org.uk> <5304B6E8.1090508@monstr.eu>
Message-ID: <20140219135938.GY2669@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 19, 2014 at 02:51:36PM +0100, Michal Simek wrote:
> On 02/19/2014 01:17 PM, Mark Brown wrote:

> > Like I said I've never seen the user you're adding for the regmap API so
> > I've no particular opinion on it.

> 2/2 is the code where I would like to use this when clk subsystem
> start to use better io helper functions then just static inline
> clk_readl/clk_writel.

> Then my 2/2 driver will be just nicer than current implementation.

OK, but I still haven't seen the code (or Lee's concerns for that
matter).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140219/beb72790/attachment.sig>
