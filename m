From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 27 Jan 2011 17:43:35 +0100
Subject: [PATCH] mmci: calculate remaining bytes at error correctly
In-Reply-To: <20110127163643.GG25968@n2100.arm.linux.org.uk>
References: <1296137666-30906-1-git-send-email-linus.walleij@stericsson.com>
	<20110127163643.GG25968@n2100.arm.linux.org.uk>
Message-ID: <AANLkTin7BEP0kpYGKyCczXY+MRG=GQ5_WgD3duDtemZ-@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/1/27 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> So, maybe we want:
>
> ? ? ? ?host->data_xfered = ((success - 1) / data->blksz) * data->blksz;
>
> instead?

So like this:
