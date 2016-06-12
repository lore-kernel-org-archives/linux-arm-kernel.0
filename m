From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 12 Jun 2016 10:45:23 -0300
Subject: [PATCH 2/2] ARM: dts: utilite-pro: add mmc card slot support
In-Reply-To: <30f2c9e9b50d47d893218811f3223b3f@rwthex-s1-b.rwth-ad.de>
References: <20160612132046.1363-1-christopher.spinrath@rwth-aachen.de>
 <30f2c9e9b50d47d893218811f3223b3f@rwthex-s1-b.rwth-ad.de>
Message-ID: <CAOMZO5B+ervJJbxsEC66Bri3LSqQTgxjgqd8sDhu_b_-m4Xrcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 12, 2016 at 10:20 AM,  <christopher.spinrath@rwth-aachen.de> wrote:

> +&usdhc3 {
> +       pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +       pinctrl-0 = <&pinctrl_usdhc3>;
> +       pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
> +       pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
> +       no-1-8-v;
> +       broken-cd;

A comment in the commit log as to why you use the 'broken-cd' property
would be helpful.

Thanks
