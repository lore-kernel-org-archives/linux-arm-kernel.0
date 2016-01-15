From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri, 15 Jan 2016 07:41:35 +0100 (CET)
Subject: [PATCH v2 24/26] devicetree: Add olimex vendor prefix
In-Reply-To: <20160115031543.GA25640@rob-hp-laptop>
References: <1452785109-6172-1-git-send-email-maxime.ripard@free-electrons.com>
 <1452785109-6172-25-git-send-email-maxime.ripard@free-electrons.com>
 <20160115031543.GA25640@rob-hp-laptop>
Message-ID: <1957693252.53435.d0a9f334-1bed-484f-886a-05dfab0e0dfa.open-xchange@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Rob Herring <robh@kernel.org> hat am 15. Januar 2016 um 04:15 geschrieben:
>
>
> On Thu, Jan 14, 2016 at 04:25:07PM +0100, Maxime Ripard wrote:
> > Olimex is an open source hardware boards vendors based in Bulgaria.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> > Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
> > 1 file changed, 1 insertion(+)
>
> Acked-by: Rob Herring <robh@kernel.org>
>

I don't think we need this twice.

It's already committed:

2193377bdade ("DT: add Olimex to vendor prefixes")

Regards
Stefan
