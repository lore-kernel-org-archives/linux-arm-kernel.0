From: avinashphilip@ti.com (Philip, Avinash)
Date: Tue, 20 Nov 2012 11:26:45 +0000
Subject: [PATCH v4 3/3] ARM: OMAP: gpmc: add DT bindings for GPMC
 timings and NAND
In-Reply-To: <1353338956-19420-4-git-send-email-zonque@gmail.com>
References: <1353338956-19420-1-git-send-email-zonque@gmail.com>
 <1353338956-19420-4-git-send-email-zonque@gmail.com>
Message-ID: <518397C60809E147AF5323E0420B992E3E9E94FE@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 20:59:16, Daniel Mack wrote:
> This patch adds basic DT bindings for OMAP GPMC.
> 
...
> +
> +	if (of_get_property(child, "ti,nand-ecc-use-elm", NULL))
> +		gpmc_nand_data->is_elm_used = 1;

Can you set to bool value (true) here.

Thanks
Avinash
