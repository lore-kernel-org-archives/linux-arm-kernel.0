From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 1 Jun 2015 22:25:07 +0200
Subject: [rtc-linux] [PATCH v5 1/6] rtc: arm: imx: snvs: change use
 syscon to access register
In-Reply-To: <1432657562-5592-2-git-send-email-Frank.Li@freescale.com>
References: <1432657562-5592-1-git-send-email-Frank.Li@freescale.com>
 <1432657562-5592-2-git-send-email-Frank.Li@freescale.com>
Message-ID: <20150601202507.GP4710@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/05/2015 at 00:25:57 +0800, Frank.Li at freescale.com wrote :
> From: Frank Li <Frank.Li@freescale.com>
> 
> snvs included rtc, on/off key, power-off module
> change to syscon to access register
> 
> Signed-off-by: Frank Li <Frank.Li@freescale.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Shawn, when applying could you please change the subject to:
rtc: snvs: use syscon to access registers

Thanks,

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
