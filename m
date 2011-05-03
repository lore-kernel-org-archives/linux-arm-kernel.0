From: tony@atomide.com (Tony Lindgren)
Date: Tue, 3 May 2011 03:39:53 -0700
Subject: [PATCH] arm: omap2plus: GPIO cleanup mach-omap2/*
In-Reply-To: <4DB9146F.2080002@compulab.co.il>
References: <1303895153-451-1-git-send-email-grinberg@compulab.co.il>
	<20110427140129.GH3755@atomide.com>
	<BANLkTik4qvrYBs4O90c8ZekW6ULh1tRxEA@mail.gmail.com>
	<4DB9146F.2080002@compulab.co.il>
Message-ID: <20110503103952.GP2092@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Igor Grinberg <grinberg@compulab.co.il> [110428 00:13]:
> On 04/27/11 18:58, Grazvydas Ignotas wrote:
> 
> > On Wed, Apr 27, 2011 at 5:01 PM, Tony Lindgren <tony@atomide.com> wrote:
> >> * Igor Grinberg <grinberg@compulab.co.il> [110427 02:02]:
> >>> use gpio_request_<one|array>() instead of multiple gpiolib calls,
> >>> remove unneeded variables, etc.
> >> Great :)
> > I think this does conflict with Mike's "omap: cleanup board files"
> > series though.
> 
> Yep, as I've stated in the description ;)
> 
> I've started working on this before Mike submitted his series and now
> I want to get some responses before any rebase work is done.

Mike's series is now applied into devel-cleanup, can you please
rebase on top of commit ff08a05b6ca3a22107d621b1417e703af25b1298?

Thanks,

Tony
