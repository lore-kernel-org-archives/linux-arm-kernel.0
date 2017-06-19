From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Mon, 19 Jun 2017 04:11:12 +0200
Subject: [PATCH v4 20/28] ARM: owl: Implement CPU enable-method for S500
In-Reply-To: <20170606005426.26446-21-afaerber@suse.de>
References: <20170606005426.26446-1-afaerber@suse.de>
 <20170606005426.26446-21-afaerber@suse.de>
Message-ID: <318d4687-64e6-764b-92e4-614ef056cc88@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 06.06.2017 um 02:54 schrieb Andreas F?rber:
> Allow to bring up CPU1.
> 
> Based on LeMaker linux-actions tree.
> 
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v3 -> v4: Unchanged
>  
>  v3: new
>  
>  arch/arm/mach-actions/Makefile  |   3 +
>  arch/arm/mach-actions/headsmp.S |  68 ++++++++++++++++
>  arch/arm/mach-actions/platsmp.c | 166 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 237 insertions(+)
>  create mode 100644 arch/arm/mach-actions/headsmp.S
>  create mode 100644 arch/arm/mach-actions/platsmp.c

Applied to linux-actions.git v4.13/arm branch:

https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-actions.git/log/?h=v4.13/arm

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
