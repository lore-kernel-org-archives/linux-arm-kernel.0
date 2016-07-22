From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 22 Jul 2016 13:01:39 -0700
Subject: [PATCH V2] ARM: BCM5301X: Specify PHY of USB 2.0 in DT
In-Reply-To: <1464811627-12218-1-git-send-email-zajec5@gmail.com>
References: <1464808585-14996-1-git-send-email-zajec5@gmail.com>
 <1464811627-12218-1-git-send-email-zajec5@gmail.com>
Message-ID: <5483f72a-1840-cde3-5d10-0b23e3f77fc9@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01/2016 01:07 PM, Rafa? Mi?ecki wrote:
> Driver for Northstar USB 2.0 PHY was added in 4.7-rc1 by:
> commit d3feb4067335 ("phy: bcm-ns-usb2: new driver for USB 2.0 PHY on
> Northstar").
> It should be used to let EHCI platform driver init PHY.
> 
> Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>

Applied, thanks
-- 
Florian
