From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 27 Jan 2011 11:16:00 -0200
Subject: [PATCH 11/13] ARM i.MX51 mx51 babbage: remove unnecessary
	CONFIG_KEYBOARD_IMX ifdefs
In-Reply-To: <1296133233-1062-12-git-send-email-s.hauer@pengutronix.de>
References: <1296133233-1062-1-git-send-email-s.hauer@pengutronix.de>
	<1296133233-1062-12-git-send-email-s.hauer@pengutronix.de>
Message-ID: <AANLkTiknJta0rJSPaJH9=0oVEfmW0rSp1U1aXFs425sZ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Thu, Jan 27, 2011 at 11:00 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
> ?arch/arm/mach-mx5/board-mx51_3ds.c | ? 13 +------------
> ?1 files changed, 1 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/mach-mx5/board-mx51_3ds.c b/arch/arm/mach-mx5/board-mx51_3ds.c
> index feb2800..58a2574 100644
> --- a/arch/arm/mach-mx5/board-mx51_3ds.c
> +++ b/arch/arm/mach-mx5/board-mx51_3ds.c

In the subject field you should put MX51_3ds instead of Babbage.

Regards,

Fabio Estevam
