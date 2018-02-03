From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 2 Feb 2018 22:01:51 -0200
Subject: [PATCH v3 1/3] ARM: dts: imx: Pass empty memory size on board dts
In-Reply-To: <1516800134-5018-1-git-send-email-marcofrk@gmail.com>
References: <1516800134-5018-1-git-send-email-marcofrk@gmail.com>
Message-ID: <CAOMZO5AKkutCx5y8z8XUniaynsUda1dwrZRa=vgWTCqOJu=tgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 24, 2018 at 11:22 AM, Marco Franchi <marcofrk@gmail.com> wrote:
> In preparation for removing 'reg = <0 0>;' from the dtsi SoC files, pass
> 'reg = <0 0 >;' to the dts/dtsi board files that do not pass the memory
> size.
>
> Signed-off-by: Marco Franchi <marco.franchi@nxp.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
