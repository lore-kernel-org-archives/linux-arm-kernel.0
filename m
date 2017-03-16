From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 16 Mar 2017 11:29:23 +0800
Subject: [PATCH v5 1/3] ARM: imx: Add GPCv2 power gating driver bindings
In-Reply-To: <20170314150540.27831-2-andrew.smirnov@gmail.com>
References: <20170314150540.27831-1-andrew.smirnov@gmail.com>
 <20170314150540.27831-2-andrew.smirnov@gmail.com>
Message-ID: <20170316032921.GZ3618@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 14, 2017 at 08:05:38AM -0700, Andrey Smirnov wrote:
> Add DT bindings for power domain driver for GPCv2 IP block found in
> i.MX7 SoCs.
> 
> Cc: yurovsky at gmail.com
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: devicetree at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Bindings patch should have the subject prefix like 'dt-bindings: ...'
than 'ARM: imx: ...'.

Shawn
