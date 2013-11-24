From: peter.chen@freescale.com (Peter Chen)
Date: Sun, 24 Nov 2013 18:12:06 +0800
Subject: [PATCHv2] usb: chipidea: add support for USB OTG controller on
 TI-NSPIRE
In-Reply-To: <1385278667-91856-1-git-send-email-dt.tangr@gmail.com>
References: <1385278667-91856-1-git-send-email-dt.tangr@gmail.com>
Message-ID: <20131124101205.GA30724@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 24, 2013 at 06:37:47PM +1100, dt.tangr at gmail.com wrote:
> From: Daniel Tang <dt.tangr@gmail.com>
> 
> Changelog v2:
>  * Rename ci13xxx to ci_hdrc
>  * Fixed alignment issues
> 
> The USB controller in TI-NSPIRE calculators are based off either Freescale's
> USB OTG controller or the USB controller found in the IMX233, both of which
> are Chipidea compatible.
> 
> This patch adds a device tree binding for the controller.
> 
> Signed-off-by: Daniel Tang <dt.tangr@gmail.com>
> ---

Please put the "Changelog v2" here, the change log should
not be in commit log, it is for review purpose.

> +};
> +
> +MODULE_DEVICE_TABLE(of, ci_hdrc_nspire_dt_ids);
> +module_platform_driver(ci_hdrc_nspire_driver);
> +
> +MODULE_ALIAS("platform:nspire_usb");
> +MODULE_ALIAS("platform:ci_hdrc_nspire");

Just curious, why you need to two alias?

-- 

Best Regards,
Peter Chen
