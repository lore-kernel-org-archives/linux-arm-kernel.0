From: horms@verge.net.au (Simon Horman)
Date: Fri, 29 Aug 2014 08:59:30 +0900
Subject: [PATCH] ARM: dts: calxeda: Correct memory map syntax
In-Reply-To: <CAL_Jsq+7iCz7rs=msnbJM1Q=Okw3S7GBB1FNabPb5-Gw9C6rcw@mail.gmail.com>
References: <1409113099-15884-1-git-send-email-horms+renesas@verge.net.au>
 <CAL_Jsq+7iCz7rs=msnbJM1Q=Okw3S7GBB1FNabPb5-Gw9C6rcw@mail.gmail.com>
Message-ID: <20140828235930.GF16165@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 27, 2014 at 07:09:39AM -0500, Rob Herring wrote:
> On Tue, Aug 26, 2014 at 11:18 PM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > Correct a syntax error by using two comma-delimited 32 bit values
> > rather than a single 64 bit value.
> >
> > This is a documentation fix and should have no run-time affect.
> >
> > This problem was introduced by 7d6ab9b8620bbca6
> > ("ARM: dts: Add Calxeda ECX-2000 support") in v3.7.
> >
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Acked-by: Rob Herring <robh@kernel.org>

I would like to withdraw this patch.
The latest information I have is that the syntax used is already correct.
