From: tony@atomide.com (Tony Lindgren)
Date: Mon, 8 Apr 2013 17:15:01 -0700
Subject: [GIT PULL] ARM: OMAP: Device Tree for 3.10
In-Reply-To: <516348B5.3060400@ti.com>
References: <516348B5.3060400@ti.com>
Message-ID: <20130409001501.GH10155@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Benoit Cousson <b-cousson@ti.com> [130408 15:50]:
> Hi Tony,
> 
> Please pull the following commits for OMAP Device Tree for v3.10.
> 
> Note that the branch is based on two other branches:
> 
> - omap-devel-b-for-3.10 from Paul to get the AM33xx missing hwmod and thus avoid a regression with Santosh's hwmod cleanup including in this DT series [1]. It avoids breaking bisect if this series is merged before Paul's fixes.
> 
> - omap-for-v3.10/usb branch to avoid nasty merge conflict in omap3.dtsi and omap4.dtsi due to the DTS patches contains in the USB branch.

Thanks pulling into omap-for-v3.10/dt.

Tony
 
> [1] https://patchwork.kernel.org/patch/2366291/
