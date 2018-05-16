From: tfiga@chromium.org (Tomasz Figa)
Date: Wed, 16 May 2018 17:08:49 +0900
Subject: [PATCH v6 09/17] media: rkisp1: add rockchip isp1 core driver
In-Reply-To: <20180308094807.9443-10-jacob-chen@iotwrt.com>
References: <20180308094807.9443-1-jacob-chen@iotwrt.com>
 <20180308094807.9443-10-jacob-chen@iotwrt.com>
Message-ID: <CAAFQd5BZm6+s=o1xEu_+E56R-k+ujAFxfytjA+N_SAcU=4A9FA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jacob, Shunqian,

On Thu, Mar 8, 2018 at 6:49 PM Jacob Chen <jacob-chen@iotwrt.com> wrote:
[snip]
> +static const struct of_device_id rkisp1_plat_of_match[] = {
> +       {
> +               .compatible = "rockchip,rk3288-cif-isp",
> +               .data = &rk3288_isp_clk_data,
> +       }, {
> +               .compatible = "rockchip,rk3399-cif-isp",
> +               .data = &rk3399_isp_clk_data,
> +       },
> +       {},
> +};

We need MODULE_DEVICE_TABLE() here.

Best regards,
Tomasz
