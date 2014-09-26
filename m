From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 26 Sep 2014 09:20:54 +0100
Subject: [PATCH] ARM: Kconfig: Open force maximum zone order for all SoCs
In-Reply-To: <9dc024498c904d48b3a25430f8d31f29@BY2PR0301MB0613.namprd03.prod.outlook.com>
References: <1409546541-4129-1-git-send-email-Li.Xiubo@freescale.com>
 <9dc024498c904d48b3a25430f8d31f29@BY2PR0301MB0613.namprd03.prod.outlook.com>
Message-ID: <20140926082054.GI5182@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 26, 2014 at 05:30:40AM +0000, Li.Xiubo at freescale.com wrote:
> Hi Russell,
> 
> I'd like to know the status of this patch.
> 
> Our Platforms depend on it.

I'm not applying it.  This option should not be exposed for general
use.  The usage pattern is clear from the existing users - propose
an alternative default value for your platform rather than making it
a user visible tweakable option.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
