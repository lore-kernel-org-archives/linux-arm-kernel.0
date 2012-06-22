From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 22 Jun 2012 10:12:21 +0800
Subject: [PATCH] ARM:MXS: Initial support for the Crystalfontz CFA-10036
In-Reply-To: <4FE32E31.2070909@free-electrons.com>
References: <1340268415-5022-1-git-send-email-maxime.ripard@free-electrons.com>
 <20120621131138.GA21418@S2101-09.ap.freescale.net>
 <4FE32E31.2070909@free-electrons.com>
Message-ID: <20120622021219.GD21418@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 21, 2012 at 04:22:41PM +0200, Maxime Ripard wrote:
> You can add by Tested-by I guess :)
> 
Thanks for reporting and testing.

> We have found that indeed the two registers were inverted compared to
> the datasheet, but why was it still working on the iMX28-evk ?
> 
I guess imx28-evk will also have issue with some stressful testing.

-- 
Regards,
Shawn
