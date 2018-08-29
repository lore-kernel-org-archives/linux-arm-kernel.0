From: robh@kernel.org (Rob Herring)
Date: Wed, 29 Aug 2018 06:13:44 -0500
Subject: [PATCH v2] clk: Convert to using %pOFn instead of device_node.name
In-Reply-To: <153549455575.129321.22566359378173086@swboyd.mtv.corp.google.com>
References: <20180828154433.5693-1-robh@kernel.org>
 <20180828154433.5693-3-robh@kernel.org>
 <153549455575.129321.22566359378173086@swboyd.mtv.corp.google.com>
Message-ID: <CAL_JsqJ35s0vfor4AdzKRvxOsqSvSD+_y4J3vYNeVk9ZW6HtjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2018 at 5:15 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Rob Herring (2018-08-28 08:44:29)
> > In preparation to remove the node name pointer from struct device_node,
> > convert printf users to use the %pOFn format specifier.
> >
> > Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> > Cc: Michael Turquette <mturquette@baylibre.com>
> > Cc: Stephen Boyd <sboyd@kernel.org>
> > Cc: linux-clk at vger.kernel.org
> > Cc: linux-arm-kernel at lists.infradead.org
> > Cc: linux-renesas-soc at vger.kernel.org
> > Cc: linux-omap at vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>

Please apply to the clock tree. There's no dependencies and removing
name will take some time.

Rob
