From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 11 Aug 2017 09:43:12 +0200
Subject: [PATCH 1/2] reset: uniphier: remove sLD3 SoC support
In-Reply-To: <20170810203059.abbmh4zhrk36shxb@rob-hp-laptop>
References: <1501987442-2583-1-git-send-email-yamada.masahiro@socionext.com>
 <1501987442-2583-2-git-send-email-yamada.masahiro@socionext.com>
 <20170810203059.abbmh4zhrk36shxb@rob-hp-laptop>
Message-ID: <1502437392.2310.6.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-08-10 at 15:30 -0500, Rob Herring wrote:
> On Sun, Aug 06, 2017 at 11:44:01AM +0900, Masahiro Yamada wrote:
> > This SoC is too old.??It is difficult to maintain any longer.
> > 
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> > 
> > ?.../devicetree/bindings/reset/uniphier-reset.txt???|??2 -
> > ?drivers/reset/reset-uniphier.c?????????????????????| 48 ++++++++
> > --------------
> > ?2 files changed, 16 insertions(+), 34 deletions(-)
> 
> Acked-by: Rob Herring <robh@kernel.org>

Added to the patch, thank you.

regards
Philipp
