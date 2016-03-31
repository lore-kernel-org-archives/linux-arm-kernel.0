From: robh@kernel.org (Rob Herring)
Date: Thu, 31 Mar 2016 16:26:08 -0500
Subject: [PATCH 0/5] ARM: dts: rockchip: small cleanups
In-Reply-To: <1459457651-4727-1-git-send-email-heiko@sntech.de>
References: <1459457651-4727-1-git-send-email-heiko@sntech.de>
Message-ID: <CAL_JsqJGwutf8C2b69a9zM=gj8zwgbumF-6qp4gSZ6k99QujSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 31, 2016 at 3:54 PM, Heiko Stuebner <heiko@sntech.de> wrote:
> Fix some missing unitnames on nodes having a reg property
> and drop unitnames on gpio-keys.
>
> This explicitly leaves out the memory nodes, as it seems
> memory without unitname will keep being allowed, also
> to keep compatibility with bootloaders who may insert the
> actual amount of memory into those nodes. [0]
>
>
> [0] http://www.spinics.net/lists/arm-kernel/msg494038.html
>
> Heiko Stuebner (5):
>   ARM: dts: rockchip: fix rk3288 power-domain unit names
>   ARM: dts: rockchip: fix missing usbphy unit-names
>   ARM: dts: rockchip: clean up gpio-keys nodes
>   ARM: dts: rockchip: drop unneeded properties from mipi node
>   ARM: dts: rockchip: add missing unitname to cpu_leakage efuse

For the series:

Acked-by: Rob Herring <robh@kernel.org>
