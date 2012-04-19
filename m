From: jamie@jamieiles.com (Jamie Iles)
Date: Thu, 19 Apr 2012 16:46:41 +0100
Subject: [PATCH 2/2] ARM: VIC: use the domain mapping function to assign
 handlers
In-Reply-To: <1334763054-19340-1-git-send-email-linus.walleij@stericsson.com>
References: <1334763054-19340-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20120419154641.GB7048@page>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 18, 2012 at 05:30:54PM +0200, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This removes the internal functions for assigning IRQ
> handlers to each interrupt in favor of using the internal
> map iterator in the irq domain code.
> 
> Cc: Jamie Iles <jamie@jamieiles.com>

I don't have a test platform up and running right now that I can give 
this a go on, but it looks good so,

Reviewed-by: Jamie Iles <jamie@jamieiles.com>

Jamie
