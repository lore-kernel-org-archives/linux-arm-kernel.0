From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 14 Oct 2011 10:27:47 +0100
Subject: [PATCH 00/16] ARM: amba: Enable module alias autogeneration for
	AMBA drivers
In-Reply-To: <20111013172404.GL21648@n2100.arm.linux.org.uk>
References: <1317830707-17517-1-git-send-email-dave.martin@linaro.org>
	<20111013165420.GA2422@localhost.localdomain>
	<20111013172404.GL21648@n2100.arm.linux.org.uk>
Message-ID: <20111014092733.GA2373@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 13, 2011 at 06:24:04PM +0100, Russell King - ARM Linux wrote:
> On Thu, Oct 13, 2011 at 05:54:20PM +0100, Dave Martin wrote:
> > Russell, did you have a view on this series?
> > 
> > Following your suggestion I was able to use the generic modpost
> > infrastructure instead of reinventing stuff, and it seemes to work out
> > quite neatly.
> > 
> > Hopefully the only possibly-contraversial change change is the
> > movement of struct amba_id.
> 
> I think it looks fine - but I would like to see the first patch getting
> a wider distribution before accepting the series - I think it needs to
> go to at least lkml.org just in case someone has an issue with it.

OK, that makes sense.  I tried to CC the appropriate people, but you're
right-- posting it to lkml would be a better way to reach the right
audience.  I'll post and see.

Thanks
---Dave
