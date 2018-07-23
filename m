From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 23 Jul 2018 11:39:51 -0300
Subject: [PATCH v2] soc: imx: gpc: fix PDN delay & improve readability
In-Reply-To: <1529316704661.7268@mixed-mode.de>
References: <1529312474617.59395@mixed-mode.de>
 <1529314029.3684.2.camel@pengutronix.de>
 <1529316704661.7268@mixed-mode.de>
Message-ID: <CAOMZO5COwPurtRvNhAGD-1jTS5FKPgsxV4e-WniMrLpVDHg7Eg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sven,

On Mon, Jun 18, 2018 at 7:11 AM, Sven Schmitt
<Sven.Schmitt@mixed-mode.de> wrote:
> - imx6_pm_domain_power_off(): reads iso and iso2sw
>   from GPC_PGC_PUPSCR_OFFS which stores the power up delays
>   => use GPC_PGC_PDNSCR_OFFS for the correct delays
>
> - remove unused #defines
>
> - GPC_PGC_DOMAIN_*: made consistent use of index defines
>
> Signed-off-by: Sven Schmitt <sven.schmitt@mixed-mode.de>

It seems you missed to send it to Shawn Guo, who is the imx maintainer.

Please run ./scripts/get_maintainer.pl 0001-your.patch and resend it
to these folks.

Thanks
