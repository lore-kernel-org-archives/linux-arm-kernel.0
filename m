From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Sat, 23 Oct 2010 10:06:21 +0200
Subject: [PATCHv6 1/3] ARM: imx: Add gpio-keys to plat-mxc
In-Reply-To: <1287801976-5324-1-git-send-email-Dinh.Nguyen@freescale.com>
References: <1287801976-5324-1-git-send-email-Dinh.Nguyen@freescale.com>
Message-ID: <4CC2977D.8060409@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dinh,

Le 23/10/2010 04:46, Dinh.Nguyen at freescale.com a ?crit :
> +struct platform_device *__init imx_add_gpio_keys(
> +		const struct gpio_keys_platform_data *pdata)
> +{
> +	return imx_add_platform_device("gpio-keys", -1, NULL,
> +		 0, pdata, sizeof(*pdata));
> +}

What is the added value of this ?
gpio-keys is not i.MX specific so why should that land in plat-mxc ?

Eric
