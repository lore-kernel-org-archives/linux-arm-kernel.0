From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 20 Jul 2018 16:07:50 -0300
Subject: [PATCH 1/2] ARM: dts: imx6qdl: Add Engicam i.Core 1.5 MX6
In-Reply-To: <1532081765-29910-2-git-send-email-jacopo@jmondi.org>
References: <1532081765-29910-1-git-send-email-jacopo@jmondi.org>
 <1532081765-29910-2-git-send-email-jacopo@jmondi.org>
Message-ID: <CAOMZO5B=pR7UMdd4-zymKm27jM9a=qb6u5zXjOahAxguoQ3kbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 20, 2018 at 7:16 AM, Jacopo Mondi <jacopo@jmondi.org> wrote:
> The 1.5 version of Engicam's i.Core MX6 CPU module features a different clock
> provider for the ethernet's PHY interface. Adjust the FEC ptp clock to
> reference CLK_ENET_REF clock source, and set SION bit of
> MX6QDL_PAD_GPIO_16__ENET_REF_CLK to adjust the input path of that pin.
>
> The newly introduced imx6ql-icore-1.5.dtsi allows to collect in a single
> place differences between version '1.0' and '1.5' of the module.
>
> Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
