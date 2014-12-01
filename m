From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 01 Dec 2014 20:10:01 +0100
Subject: [PATCH] ASoC: snd-soc-afeb9260: delete driver as board has just
 been removed
In-Reply-To: <1417449472-13498-1-git-send-email-nicolas.ferre@atmel.com>
References: <1417449472-13498-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <1417461001.30245.35.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicholas,

On Mon, 2014-12-01 at 16:57 +0100, Nicolas Ferre wrote:
> During the removal of all AT91 !DT boards, we removed the AFEB9260. This driver
> is !DT and was only used by this board, so we delete it as well.
> 
> Reported-by: Paul Bolle <pebolle@tiscali.nl>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  sound/soc/atmel/Makefile           |   1 -
>  sound/soc/atmel/snd-soc-afeb9260.c | 151 -------------------------------------
>  2 files changed, 152 deletions(-)
>  delete mode 100644 sound/soc/atmel/snd-soc-afeb9260.c

This doesn't touch the entry for SND_AT91_SOC_AFEB9260 in
sound/soc/atmel/Kconfig. That doesn't look right to me.

Thanks,


Paul Bolle
