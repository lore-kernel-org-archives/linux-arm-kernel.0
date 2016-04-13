From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 13 Apr 2016 09:12:54 -0700
Subject: [PATCH dt] ARM: BCM5301X: Set vcc-gpio for USB controllers of few
 devices
In-Reply-To: <1458748367-18294-1-git-send-email-zajec5@gmail.com>
References: <1458748367-18294-1-git-send-email-zajec5@gmail.com>
Message-ID: <570E7006.60100@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/03/16 08:52, Rafa? Mi?ecki wrote:
> There are few devices that have USB power controlled using GPIO. Linux
> USB host driver (bcma-hcd) already supports this by reading vcc-gpio
> from DT. Set it properly for all known devices.
> 
> Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>

Applied to devicetree/next, thanks!
-- 
Florian
