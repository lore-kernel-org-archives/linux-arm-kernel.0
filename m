From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 13 Apr 2017 19:23:21 -0300
Subject: [PATCH 8/8] ARM: dts: imx7d-sdb: Enable PCIe peripheral
In-Reply-To: <20170413133242.5068-9-andrew.smirnov@gmail.com>
References: <20170413133242.5068-1-andrew.smirnov@gmail.com>
 <20170413133242.5068-9-andrew.smirnov@gmail.com>
Message-ID: <CAOMZO5D=ceiTRuM3-vjc-qnd=3yKKYHzwVYwFUWkaLZr6Lnb8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 13, 2017 at 10:32 AM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:

> +&pcie {
> +       pinctrl-names = "default";
> +       reset-gpio = <&gpio_spi 1 GPIO_ACTIVE_LOW>;
> +       disable-gpio = <&gpio_spi 0 GPIO_ACTIVE_LOW>;

I don't see this property in linux-next.
