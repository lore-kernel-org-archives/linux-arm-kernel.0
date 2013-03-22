From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 22 Mar 2013 15:51:45 -0400
Subject: [PATCH 1/2] gpio: mvebu: add dbg_show function
In-Reply-To: <1363978188-31200-2-git-send-email-simon.guinot@sequanux.org>
References: <1363978188-31200-1-git-send-email-simon.guinot@sequanux.org>
 <1363978188-31200-2-git-send-email-simon.guinot@sequanux.org>
Message-ID: <20130322195145.GM13280@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus,

On Fri, Mar 22, 2013 at 07:49:47PM +0100, Simon Guinot wrote:
> This patch adds a dedicated dbg_show function to the gpio-mvebu driver.
> In addition to the generic gpiolib informations, this function displays
> informations related with the specific Marvell registers (blink enable,
> data in polarity, interrupt masks and cause).
> 
> Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
> ---
>  drivers/gpio/gpio-mvebu.c |   59 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)

It'd probably be easiest to split this series up since the two patches
don't really depend on one another at all.

If you agree, I'll pull in the plat-orion/ patch.

thx,

Jason.
