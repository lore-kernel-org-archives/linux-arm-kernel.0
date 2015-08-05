From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 5 Aug 2015 20:10:32 +0800
Subject: [PATCH v5 0/6] add device tree support for mxc rtc
In-Reply-To: <1437946673-7402-1-git-send-email-tremyfr@gmail.com>
References: <1437946673-7402-1-git-send-email-tremyfr@gmail.com>
Message-ID: <20150805121032.GK12927@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 26, 2015 at 11:37:47PM +0200, Philippe Reynes wrote:
> Philippe Reynes (6):
>   imx31: add a second rtc clock

clk: imx: ...

>   imx35: define two clocks for rtc

clk: imx35: ...

>   rtc: mxc: use a second rtc clock
>   dt-binding: document the binding for mxc rtc
>   rtc: mxc: add support of device tree
>   imx27: dt: add support of internal rtc

ARM: dts: imx27: ...

Applied all with above minor changes on subject prefix.

Shawn
