From: horms@verge.net.au (Simon Horman)
Date: Thu, 30 Aug 2018 16:37:31 +0200
Subject: [PATCH] ARM: shmobile: Convert to using %pOFn instead of
 device_node.name
In-Reply-To: <CAMuHMdV9QeMRSTzcbCeUHFi_a77ceumEW6mzoC+zrpEUsZEM=g@mail.gmail.com>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-2-robh@kernel.org>
 <CAMuHMdV9QeMRSTzcbCeUHFi_a77ceumEW6mzoC+zrpEUsZEM=g@mail.gmail.com>
Message-ID: <20180830143730.dw26fj6dldfeajjn@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2018 at 09:24:20AM +0200, Geert Uytterhoeven wrote:
> On Tue, Aug 28, 2018 at 3:54 AM Rob Herring <robh@kernel.org> wrote:
> > In preparation to remove the node name pointer from struct device_node,
> > convert printf users to use the %pOFn format specifier.
> >
> > Cc: Simon Horman <horms@verge.net.au>
> > Cc: Magnus Damm <magnus.damm@gmail.com>
> > Cc: linux-arm-kernel at lists.infradead.org
> > Cc: linux-renesas-soc at vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks Rob, thanks Geert, applied for v4.20.
