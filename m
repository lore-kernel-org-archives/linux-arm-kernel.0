From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Oct 2011 18:24:04 +0100
Subject: [PATCH 00/16] ARM: amba: Enable module alias autogeneration
	for AMBA drivers
In-Reply-To: <20111013165420.GA2422@localhost.localdomain>
References: <1317830707-17517-1-git-send-email-dave.martin@linaro.org>
	<20111013165420.GA2422@localhost.localdomain>
Message-ID: <20111013172404.GL21648@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 13, 2011 at 05:54:20PM +0100, Dave Martin wrote:
> Russell, did you have a view on this series?
> 
> Following your suggestion I was able to use the generic modpost
> infrastructure instead of reinventing stuff, and it seemes to work out
> quite neatly.
> 
> Hopefully the only possibly-contraversial change change is the
> movement of struct amba_id.

I think it looks fine - but I would like to see the first patch getting
a wider distribution before accepting the series - I think it needs to
go to at least lkml.org just in case someone has an issue with it.
