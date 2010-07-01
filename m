From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 1 Jul 2010 15:36:38 +0100
Subject: [PATCH 2/3] ASoC: DaVinci: Added selection of clk input pin
	for McBSP
In-Reply-To: <1277905678-4695-3-git-send-email-lamiaposta71@gmail.com>
References: <1277905678-4695-1-git-send-email-lamiaposta71@gmail.com>
	<1277905678-4695-3-git-send-email-lamiaposta71@gmail.com>
Message-ID: <20100701143638.GD8742@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 30, 2010 at 03:47:57PM +0200, Raffaele Recalcati wrote:

> +	/* To be used when cpu gets clock from external pin */
> +	int clk_input_pin;
> +

As previously indicated please say how to use this.

> +		default:
> +			printk(KERN_ERR "%s:bad clk_input_pin\n", __func__);

Use dev_err().
