From: timur@tabi.org (Timur Tabi)
Date: Thu, 17 Oct 2013 07:15:03 -0500
Subject: [PATCHv1 1/8] ALSA: Add SAI SoC Digital Audio Interface driver.
In-Reply-To: <1382000477-17304-2-git-send-email-Li.Xiubo@freescale.com>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
 <1382000477-17304-2-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <525FD4C7.3050806@tabi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Xiubo Li wrote:
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	sai->base = devm_ioremap_resource(&pdev->dev, res);

Why not use of_iomap()?
