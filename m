From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 6 Feb 2013 17:52:22 +0000
Subject: [PATCH 1/2] ARM: netx: bump IRQ offset to 64
In-Reply-To: <1360168530-20337-1-git-send-email-linus.walleij@linaro.org>
References: <1360168530-20337-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20130206175222.GG6473@sycamore.jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Wed, Feb 06, 2013 at 05:35:30PM +0100, Linus Walleij wrote:
> The Netx IRQs offset from zero, which is illegal, since Linux
> IRQ 0 is NO_IRQ.
> 
> Cc: Jamie Iles <jamie@jamieiles.com>

Reviewed-by: Jamie Iles <jamie@jamieiles.com>

> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Jamie, Sascha: are you actually booting this machine from time
> to time? I think this has been broken for a while. I hope HEAD
> plus this patch will make it work anyway.

No, I've never had a netx machine and have only been able to compile 
test in the past.  Perhaps it's my memory, but I seem to recall someone 
(Russell maybe?) suggesting deleting netx at some point in the past.

Jamie
