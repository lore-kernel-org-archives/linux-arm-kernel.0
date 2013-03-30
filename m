From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 30 Mar 2013 17:00:20 -0400
Subject: [PATCH v2 2/2] ARM: Orion: add dbg_show function to gpio-orion
 driver
In-Reply-To: <1364136330-28193-3-git-send-email-simon.guinot@sequanux.org>
References: <1364136330-28193-1-git-send-email-simon.guinot@sequanux.org>
 <1364136330-28193-3-git-send-email-simon.guinot@sequanux.org>
Message-ID: <20130330210020.GZ13280@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 24, 2013 at 03:45:30PM +0100, Simon Guinot wrote:
> This patch adds a dedicated dbg_show function to the gpio-mvebu driver.
> In addition to the generic gpiolib informations, this function displays
> informations related with the specific Marvell registers (blink enable,
> data in polarity, interrupt masks and cause).
> 
> Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
> ---
> Changes for v2:
>  - In order to match registers type, swith msk type to u32.
> 
>  arch/arm/plat-orion/gpio.c |   59 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)

Ahh, ok.  I've replaced the previous version with this one in mvebu/soc

thx,

Jason.
