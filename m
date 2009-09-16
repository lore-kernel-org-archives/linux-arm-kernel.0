From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 16 Sep 2009 23:51:03 +0200
Subject: [PATCH] at91: add AC97 support to at91sam9g45 series and
	at91sam9m10g45ek board
In-Reply-To: <1253122902-15647-2-git-send-email-nicolas.ferre@atmel.com>
References: <1253122902-15647-1-git-send-email-nicolas.ferre@atmel.com>
	<1253122902-15647-2-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20090916215103.GF4172@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19:41 Wed 16 Sep     , Nicolas Ferre wrote:
> Add the support of AC97 on the at91sam9g45 chip series and -ek board.
> It will share the code with AVR32 ac97c alsa driver "atmel_ac97c".
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  arch/arm/mach-at91/at91sam9g45_devices.c |   55 ++++++++++++++++++++++++++++++
>  arch/arm/mach-at91/board-sam9m10g45ek.c  |   10 +++++
>  2 files changed, 65 insertions(+), 0 deletions(-)
Looks fine

Best Regards,
J.
