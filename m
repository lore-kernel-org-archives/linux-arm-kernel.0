From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 14 Mar 2017 12:41:29 -0300
Subject: [PATCH] ARM: dts: imx7s: Do not claim i.MX51 compatibility for SRC
In-Reply-To: <20170314153357.32463-1-andrew.smirnov@gmail.com>
References: <20170314153357.32463-1-andrew.smirnov@gmail.com>
Message-ID: <CAOMZO5Cx8EnD=nJiXoE49mMug_2=qik8nmoHrtJVZZnScarZkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 14, 2017 at 12:33 PM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:
> System Reset Controller in i.MX7 doesn't have any commonality with IP
> block found in i.MX5 and i.MX6 SoC families. Given that and the new
> upstream driver for i.MX7 variant (see
> https://lkml.org/lkml/2017/2/21/466) remove "fsl,imx51-src" from
> compatibility string.
>
> Cc: yurovsky at gmail.com
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: devicetree at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
