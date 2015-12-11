From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 11 Dec 2015 09:37:37 -0200
Subject: [PATCH 1/3] ARM: dts: imx: Add basic dts support for imx6qp
In-Reply-To: <1449830722-26607-1-git-send-email-b51503@freescale.com>
References: <1449830722-26607-1-git-send-email-b51503@freescale.com>
Message-ID: <CAOMZO5C8mTotbpOmKkxKOXmBWc-N_zm7xn-fU5gFUgAFCiyokw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 11, 2015 at 8:45 AM, Bai Ping <b51503@freescale.com> wrote:
> The i.MX6Qual Plus processor is an high performance SOC of i.MX6 family.
> It has enhanced graphics performance and increased overall memory bandwidth
> compared to i.MX6Q. Most of the design are same as i.MX6Qual/Dual, so code
> for i.MX6Qual can be resued by this chip. The revision number is identied as
> i.MX6Q Rev2.0, but actually it is a new chip, as we did many change to the
> overall architecture.
>
> This patch adds basic dts file for the new i.MX6Qual Plus processor.
>
> Signed-off-by: Bai Ping <b51503@freescale.com>
> ---
>  arch/arm/boot/dts/Makefile                |   2 +
>  arch/arm/boot/dts/imx6q.dtsi              |   2 +-
>  arch/arm/boot/dts/imx6qdl-sabresd.dtsi    |   1 +
>  arch/arm/boot/dts/imx6qp-sabreauto.dts    |  67 +++++++++++++
>  arch/arm/boot/dts/imx6qp-sabresd.dts      |  59 +++++++++++
>  arch/arm/boot/dts/imx6qp.dtsi             | 157 ++++++++++++++++++++++++++++++
>  include/dt-bindings/clock/imx6qdl-clock.h |  16 ++-

Better split this in three patches:

- Add imx6qp SoC support
- Add imx6qdl-sabresd support
- Add imx6qp-sabreauto support
