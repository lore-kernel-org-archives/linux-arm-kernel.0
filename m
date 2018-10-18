From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 18 Oct 2018 12:11:21 +0900
Subject: [PATCH v2 2/2] dt-bindings: uniphier: move cache-uniphier.txt to
 vendor directory
In-Reply-To: <20181017200022.GA14782@bogus>
References: <1539318324-4938-1-git-send-email-yamada.masahiro@socionext.com>
 <1539318324-4938-2-git-send-email-yamada.masahiro@socionext.com>
 <20181017200022.GA14782@bogus>
Message-ID: <CAK7LNAQ+j4pRxCorfyf23L8ZRXV_mF-uQd3ab7rwP9vKktsE+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,


On Thu, Oct 18, 2018 at 5:01 AM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, 12 Oct 2018 13:25:24 +0900, Masahiro Yamada wrote:
> > Now, the Socionext vendor directory is available at
> > Documentation/devicetree/bindings/arm/socionext/
> >
> > Move cache-uniphier.txt over to it.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
> > Changes in v2:
> >   - New patch
> >
> >  .../devicetree/bindings/arm/{uniphier => socionext}/cache-uniphier.txt    | 0
> >  1 file changed, 0 insertions(+), 0 deletions(-)
> >  rename Documentation/devicetree/bindings/arm/{uniphier => socionext}/cache-uniphier.txt (100%)
> >
>
> Reviewed-by: Rob Herring <robh@kernel.org>


Thanks for your review!

You gave your Reviewed-by twice to 2/2,
but nothing to 1/2.

Is the first patch under review?
Or, did you accidentally do that
instead of replying to each of the two?


-- 
Best Regards
Masahiro Yamada
