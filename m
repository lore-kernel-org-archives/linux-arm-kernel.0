From: cjb@laptop.org (Chris Ball)
Date: Sat, 09 Jul 2011 16:58:48 -0400
Subject: [PATCH V3] MMC: PM: add suspend/resume in atmel-mci
In-Reply-To: <1309779505-25509-1-git-send-email-nicolas.ferre@atmel.com>
	(Nicolas Ferre's message of "Mon, 4 Jul 2011 13:38:25 +0200")
References: <1309530754.4373.3.camel@hcegtvedt.norway.atmel.com>
	<1309779505-25509-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <m2iprbkw6v.fsf@bob.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jul 04 2011, Nicolas Ferre wrote:
> Take care of slots while going to suspend state.
>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
> V3: take care of each slot SUSPENDED state
>     (adding a status bit in the slot "flags")
> V2: move to pm_ops

Thanks, I've merged v3 of this patch for mmc-next/3.1 with Felipe's
Reviewed-by, and your [2/2] kconfig change.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
