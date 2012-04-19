From: jamie@jamieiles.com (Jamie Iles)
Date: Thu, 19 Apr 2012 16:44:36 +0100
Subject: [PATCH 1/2] ARM: VIC: respect list of valid sources
In-Reply-To: <1334763043-19304-1-git-send-email-linus.walleij@stericsson.com>
References: <1334763043-19304-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20120419154436.GA7048@page>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 18, 2012 at 05:30:43PM +0200, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> The current IRQ domain implementation in the VIC allocates 32
> interrupts for each VIC instance no matter whether the
> controller actually use all the IRQs or not. Alter this so
> we only allocate a domain up until the last IRQ marked valid.
> 
> Cc: Jamie Iles <jamie@jamieiles.com>

Looks good to me.

Reviewed-by: Jamie Iles <jamie@jamieiles.com>

Jamie
