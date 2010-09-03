From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 3 Sep 2010 15:05:34 +0200
Subject: [PATCH] AT91: SAM9G45 - add a separate clock entry for every
	single TC block
In-Reply-To: <1283517093-12628-1-git-send-email-fg@emlix.com>
References: <1283517093-12628-1-git-send-email-fg@emlix.com>
Message-ID: <20100903130534.GB17702@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13:31 Fri 03 Sep     , Fabian Godehardt wrote:
> Without this patch you will not be able to register the first block
> because of the second association call on at91_add_device_tc().
> 
> Signed-off-by: Fabian Godehardt <fg@emlix.com>
duplicate code is not a good idea

this is one of the reason I'm think to drop the current clock assotion code of
at91 to use the generic clkdev

here you can also do not specify the device as the clock is not device
specific

Best Regards,
J.
