From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 29 Jan 2014 11:29:04 +0100
Subject: [PATCH RESEND 1/4] clk: clk-s2mps11: Refactor for including
 support for  other MFD clocks
In-Reply-To: <mvd17-4vW-3@gated-at.bofh.it>
References: <m8Uox-5kN-11@gated-at.bofh.it> <mtgmt-44E-3@gated-at.bofh.it>
 <mtgmu-44E-27@gated-at.bofh.it> <muwSe-WJ-17@gated-at.bofh.it>
 <muCkW-RP-15@gated-at.bofh.it> <mva3f-bR-7@gated-at.bofh.it>
 <mvd17-4vW-3@gated-at.bofh.it>
Message-ID: <1390991344.2207.8.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> 
> Quoting Mark Brown (2013-12-31 08:09:16)
> > On Mon, Dec 30, 2013 at 09:33:50AM +0530, Tushar Behera wrote:
> > 
> > > Commit 1b1ccee1e821 "mfd: s2mps11: Fix build after regmap field rename
> > > in sec-core.c" is also touching this file, which is in Mark's tree
> > > right now. If I rebase
> > 
> > It's been in Linus' tree for a while now.
> 
> OK, so I merged the two patches into clk-next, then merged clk-next into
> next-20131224 and the merge is super trivial to resolve. So I propose
> that we just let it get resolved in linux-next the usual way.
> 
> Any objections? If not I'll take these two patches into clk-next.

Did you merged these patches into clk-next? Unfortunately I couldn't
find them (clk-next, next).

I am asking because I want to send patches with support for S2MPS14
clock (based on these patches).

Best regards,
Krzysztof
