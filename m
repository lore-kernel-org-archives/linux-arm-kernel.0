From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 30 Mar 2013 16:44:59 -0400
Subject: [PATCH 2/2] ARM: Orion: add dbg_show function to gpio-orion driver
In-Reply-To: <1363978188-31200-3-git-send-email-simon.guinot@sequanux.org>
References: <1363978188-31200-1-git-send-email-simon.guinot@sequanux.org>
 <1363978188-31200-3-git-send-email-simon.guinot@sequanux.org>
Message-ID: <20130330204459.GW13280@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 22, 2013 at 07:49:48PM +0100, Simon Guinot wrote:
> This patch adds a dedicated dbg_show function to the gpio-mvebu driver.
> In addition to the generic gpiolib informations, this function displays
> informations related with the specific Marvell registers (blink enable,
> data in polarity, interrupt masks and cause).
> 
> Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
> ---
>  arch/arm/plat-orion/gpio.c |   59 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)

Applied to mvebu/soc

thx,

Jason.
