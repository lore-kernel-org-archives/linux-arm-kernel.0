From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 12 Feb 2018 13:44:54 -0200
Subject: [PATCH] ARM: dts: imx6: remove GPU subsystem nodes
In-Reply-To: <20180212152158.11823-1-l.stach@pengutronix.de>
References: <20180212152158.11823-1-l.stach@pengutronix.de>
Message-ID: <CAOMZO5D9nB_Q1JOSouha44k4VU0r_KrPGBu6jjV4wUxw5pLm5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lucas,

On Mon, Feb 12, 2018 at 1:21 PM, Lucas Stach <l.stach@pengutronix.de> wrote:
> They aren't needed by the etnaviv driver anymore and have been removed
> from the binding.
>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
> This patch is aimed at the 4.17 merge window, as this is when the
> etnaviv change will land.
> ---
>  arch/arm/boot/dts/imx6dl.dtsi | 5 -----
>  arch/arm/boot/dts/imx6q.dtsi  | 5 -----

Looks like you missed imx6sx.dtsi?
