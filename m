From: notasas@gmail.com (Grazvydas Ignotas)
Date: Wed, 27 Apr 2011 18:58:28 +0300
Subject: [PATCH] arm: omap2plus: GPIO cleanup mach-omap2/*
In-Reply-To: <20110427140129.GH3755@atomide.com>
References: <1303895153-451-1-git-send-email-grinberg@compulab.co.il>
	<20110427140129.GH3755@atomide.com>
Message-ID: <BANLkTik4qvrYBs4O90c8ZekW6ULh1tRxEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 27, 2011 at 5:01 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Igor Grinberg <grinberg@compulab.co.il> [110427 02:02]:
>> use gpio_request_<one|array>() instead of multiple gpiolib calls,
>> remove unneeded variables, etc.
>
> Great :)

I think this does conflict with Mike's "omap: cleanup board files"
series though.
