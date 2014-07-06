From: emilio@elopez.com.ar (=?ISO-8859-1?Q?Emilio_L=F3pez?=)
Date: Sun, 06 Jul 2014 00:23:48 -0300
Subject: [linux-sunxi] [PATCH v10 2/2] dmaengine: sun6i: Add driver for
 the Allwinner A31 DMA controller
In-Reply-To: <1404134454-25513-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1404134454-25513-1-git-send-email-maxime.ripard@free-electrons.com>
 <1404134454-25513-3-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <53B8C144.7010208@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

El 30/06/14 10:20, Maxime Ripard escribi?:
> The Allwinner A31 has a 16 channels DMA controller that it shares with the
> newer A23. Although sharing some similarities with the DMA controller of the
> older Allwinner SoCs, it's significantly different, I don't expect it to be
> possible to share the driver for these two.
>
> The A31 Controller is able to memory-to-memory or memory-to-device transfers on
> the 16 channels in parallel.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---
(...)
> +
> +static struct of_device_id sun6i_dma_match[] = {
> +	{ .compatible = "allwinner,sun6i-a31-dma" }
> +};

The empty sentinel is missing here

Cheers,

Emilio
