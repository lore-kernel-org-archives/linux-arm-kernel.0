From: robh@kernel.org (Rob Herring)
Date: Mon, 8 Oct 2018 09:59:19 -0500
Subject: [PATCH 05/36] dt-bindings: arm: renesas: Move 'renesas,prr'
 binding to its own doc
In-Reply-To: <CAMuHMdV=HaVhGf-7-21OHb05dCc0q9MDUNknAcybEiGSxATeEA@mail.gmail.com>
References: <20181005165848.3474-1-robh@kernel.org>
 <20181005165848.3474-6-robh@kernel.org>
 <CAMuHMdV=HaVhGf-7-21OHb05dCc0q9MDUNknAcybEiGSxATeEA@mail.gmail.com>
Message-ID: <CAL_JsqJGGRfoEb_TjZy2X9QwjfAdoxs_EB+cLNmszHOE8-OtHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 8, 2018 at 2:05 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Rob,
>
> On Fri, Oct 5, 2018 at 6:58 PM Rob Herring <robh@kernel.org> wrote:
> > In preparation to convert board-level bindings to json-schema, move
> > various misc SoC bindings out to their own file.
> >
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Simon Horman <horms@verge.net.au>
> > Cc: Magnus Damm <magnus.damm@gmail.com>
> > Cc: devicetree at vger.kernel.org
> > Cc: linux-renesas-soc at vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
>
> Looks good to me, but needs a rebase, as the PRR section has been extended
> in -next.

Is this something you all can apply still for 4.20?

Rob
