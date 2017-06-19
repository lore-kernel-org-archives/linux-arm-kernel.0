From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Mon, 19 Jun 2017 06:12:41 +0200
Subject: [PATCH v4 27/28] soc: actions: owl-sps: Factor out
 owl_sps_set_pg() for power-gating
In-Reply-To: <20170606005426.26446-28-afaerber@suse.de>
References: <20170606005426.26446-1-afaerber@suse.de>
 <20170606005426.26446-28-afaerber@suse.de>
Message-ID: <95ca3ef8-dff6-e32e-acf4-80feecceac52@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 06.06.2017 um 02:54 schrieb Andreas F?rber:
> Allow the SMP code to reuse PM domain code for CPU2/CPU3 wakeup.
> 
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v4: new
>  
>  drivers/soc/actions/Kconfig          |  4 +++
>  drivers/soc/actions/Makefile         |  1 +
>  drivers/soc/actions/owl-sps-helper.c | 51 ++++++++++++++++++++++++++++++++++++
>  drivers/soc/actions/owl-sps.c        | 34 +++---------------------
>  include/linux/soc/actions/owl-sps.h  | 11 ++++++++
>  5 files changed, 70 insertions(+), 31 deletions(-)
>  create mode 100644 drivers/soc/actions/owl-sps-helper.c
>  create mode 100644 include/linux/soc/actions/owl-sps.h

Applied to linux-actions.git v4.13/soc branch:

https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-actions.git/log/?h=v4.13/soc

Needs to get merged first so that arm branch can start using it.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
