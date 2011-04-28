From: grinberg@compulab.co.il (Igor Grinberg)
Date: Thu, 28 Apr 2011 10:17:03 +0300
Subject: [PATCH] arm: omap2plus: GPIO cleanup mach-omap2/*
In-Reply-To: <BANLkTik4qvrYBs4O90c8ZekW6ULh1tRxEA@mail.gmail.com>
References: <1303895153-451-1-git-send-email-grinberg@compulab.co.il>	<20110427140129.GH3755@atomide.com>
	<BANLkTik4qvrYBs4O90c8ZekW6ULh1tRxEA@mail.gmail.com>
Message-ID: <4DB9146F.2080002@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/27/11 18:58, Grazvydas Ignotas wrote:

> On Wed, Apr 27, 2011 at 5:01 PM, Tony Lindgren <tony@atomide.com> wrote:
>> * Igor Grinberg <grinberg@compulab.co.il> [110427 02:02]:
>>> use gpio_request_<one|array>() instead of multiple gpiolib calls,
>>> remove unneeded variables, etc.
>> Great :)
> I think this does conflict with Mike's "omap: cleanup board files"
> series though.

Yep, as I've stated in the description ;)

I've started working on this before Mike submitted his series and now
I want to get some responses before any rebase work is done.

-- 
Regards,
Igor.
