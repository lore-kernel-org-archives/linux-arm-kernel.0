From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 24 Feb 2011 11:06:37 -0700 (MST)
Subject: [PATCH] OMAP4: clock: Support divider selection for auxclks
In-Reply-To: <1298557696-1726-1-git-send-email-rnayak@ti.com>
References: <1298557696-1726-1-git-send-email-rnayak@ti.com>
Message-ID: <alpine.DEB.2.00.1102241105540.6198@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rajendra,

On Thu, 24 Feb 2011, Rajendra Nayak wrote:

> On OMAP4 the auxclk nodes (part of SCRM) support both
> divider as well as parent selection.
> Supporting this requires splitting the existing nodes
> (which support only parent selection) into
> two nodes, one for parent and another for
> divider selection.
> The nodes for parent selection are named
> auxclk*_src_ck and the ones for divider
> selection as auxclk*_ck
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Tested-by: Anand Gadiyar <gadiyar@ti.com>

Thanks.  Has the autogeneration script been updated?


- Paul
