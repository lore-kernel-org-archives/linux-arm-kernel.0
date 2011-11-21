From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Nov 2011 12:31:53 +0000
Subject: [PATCH 0/2 REPOST] ARM: amba: Enable module alias
 autogeneration for AMBA drivers
In-Reply-To: <1321872510-2562-1-git-send-email-dave.martin@linaro.org>
References: <1321872510-2562-1-git-send-email-dave.martin@linaro.org>
Message-ID: <20111121123153.GQ9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 21, 2011 at 10:48:28AM +0000, Dave Martin wrote:
> [This is a partial repost of a series previously posted to alkml.
> 
> This post contains the core changes.  The driver-specific changes
> can be found on alkml.]

As this has been posted a few times to LKML and no one seems to have
interest in it, I'll take the silence as indicating no objections
to the changes in include/linux/mod_devicetable.h and
scripts/mod/file2alias.c.

So I think this is ready for merging.
