From: will.deacon@arm.com (Will Deacon)
Date: Tue, 20 Sep 2011 00:14:07 +0100
Subject: [PATCH 1/2] ARM: debug: Add CLSP711X_UART1 config choice
In-Reply-To: <4E77BE34.6070702@codeaurora.org>
References: <20110916114140.GA31334@e102144-lin.cambridge.arm.com>
	<1316455300-5752-1-git-send-email-sboyd@codeaurora.org>
	<20110919212502.GB23613@e102144-lin.cambridge.arm.com>
	<4E77BE34.6070702@codeaurora.org>
Message-ID: <20110919231407.GA28502@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 19, 2011 at 11:12:04PM +0100, Stephen Boyd wrote:
> On 09/19/11 14:25, Will Deacon wrote:
> >
> > Would you like me to take the three patches in with the ones I currently
> > have for other platforms (Realview, Samsung, imx) or would you prefer to
> > handle these separately? I was planning to send all of the platform bits to
> > Arnd once I've got my branches sorted out (been on holiday for the past two
> > weeks).
> >
> 
> If you want to handle them that sounds fine. I can't figure out who is
> coordinating the DEBUG_LL changes. It seems that Russell has at least
> applied the initial DEBUG_LL patches, so his tree will have some
> breakage without this fixup patch.

I sent the main changes via Russell and I plan to send new platforms moving
to the Kconfig choice via Arnd. However, as you point out, there's some breakage
without your three patches applied, so actually it's probably best if you
send these via the patch system. In which case:

Acked-by: Will Deacon <will.deacon@arm.com>

(this is for the second version of the Footbridge patch too)

> I have some more patches on top of this one for MSM DEBUG_LL support
> too. Hopefully I can send them out in a little bit.

Ok, great. These are the ones that can go via Arnd with imx, Realview etc.

Cheers,

Will
