From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Fri, 05 Nov 2010 12:20:23 +0100
Subject: [PATCH 2/2] backlight: Fix blanking for L4F00242T03 LCD
In-Reply-To: <1288955345.28481.15435.camel@rex>
References: <1275731441-7612-1-git-send-email-marek.vasut@gmail.com>
	<1275731441-7612-2-git-send-email-marek.vasut@gmail.com>
	<1288954089.3072.10.camel@realization>
	<1288955345.28481.15435.camel@rex>
Message-ID: <1288956023.3072.12.camel@realization>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ven, 2010-11-05 at 11:09 +0000, Richard Purdie wrote:
> On Fri, 2010-11-05 at 11:48 +0100, Alberto Panizzo wrote:
> > On sab, 2010-06-05 at 11:50 +0200, Marek Vasut wrote:
> > > The LCD was turned on if the variable power was > 0, but that was incorrect. The
> > > LCD has to be turned on in NORMAL and UNBLANK case.
> > > 
> > > Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> > 
> > Richard,
> > Are you still maintaining the backlight tree?
> > These two patches never hit the mainline since gen, I hope this will 
> > happen soon since they really fix bugs :)
> > 
> > Best Regards,
> > Alberto!
> > 
> > Oh, add also this tag if possible:
> > 
> > Acked-by: Alberto Panizzo <maramaopercheseimorto@gmail.com>
> 
> I've talked with Andrew Morton and we've come up with a new plan to
> handle the backlight patches. I acked these the other day and they
> should be heading into -rc2.
> 
> Cheers,
> 
> Richard

Ok, thank you for the quick answer!

Cheers,

-- 
Alberto!

        Be Persistent!
                - Greg Kroah-Hartman (FOSDEM 2010)
