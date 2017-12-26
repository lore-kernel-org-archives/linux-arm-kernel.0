From: robh@kernel.org (Rob Herring)
Date: Tue, 26 Dec 2017 15:57:15 -0600
Subject: [PATCH 1/1] power: reset: remove unused imx-snvs-poweroff driver
In-Reply-To: <1513938539-20873-1-git-send-email-aisheng.dong@nxp.com>
References: <1513938539-20873-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20171226215715.ph5vjvmkvchvrnsd@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 22, 2017 at 06:28:59PM +0800, Dong Aisheng wrote:
> There's no user of it in kernel now and it basically functions the same
> as the generic syscon-poweroff.c to which we have already switched.
> So let's remove it.
> 
> Cc: Robin Gong <yibin.gong@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  .../bindings/power/reset/imx-snvs-poweroff.txt     | 23 --------

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/power/reset/Kconfig                        |  9 ---
>  drivers/power/reset/Makefile                       |  1 -
>  drivers/power/reset/imx-snvs-poweroff.c            | 66 ----------------------
>  4 files changed, 99 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/power/reset/imx-snvs-poweroff.txt
>  delete mode 100644 drivers/power/reset/imx-snvs-poweroff.c
