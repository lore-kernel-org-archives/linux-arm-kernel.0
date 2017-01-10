From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 10 Jan 2017 14:18:20 +0800
Subject: [PATCH v5 2/2] ARM: dts: vf610-zii-dev: Add .dts file for rev. C
In-Reply-To: <20170107200654.26056-2-andrew.smirnov@gmail.com>
References: <20170107200654.26056-1-andrew.smirnov@gmail.com>
 <20170107200654.26056-2-andrew.smirnov@gmail.com>
Message-ID: <20170110061818.GY20956@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 07, 2017 at 12:06:54PM -0800, Andrey Smirnov wrote:
> Add .dts file for rev. C of the board by factoring out commonalities
> into a shared include file (vf610-zii-dev-rev-b-c.dtsi) and deriving
> revision specific file from it (vf610-zii-dev-rev-b.dts and
> vf610-zii-dev-reb-c.dts).
> 
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: devicetree at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> Cc: andrew at lunn.ch
> Cc: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
> Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> Cc: cphealy at gmail.com
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

This patch doesn't apply to my imx/dt branch.  Please rebase.  Also
please ensure the copyright text is the correct one [1].

Shawn

[1] https://git.kernel.org/cgit/linux/kernel/git/shawnguo/linux.git/diff/?h=imx/dt&id=13283626c889fd5c03b485d54c924b795aca1c1e
