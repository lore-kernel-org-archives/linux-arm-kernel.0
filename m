From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 21 May 2018 12:19:43 -0700
Subject: [PATCH 1/2] rtc: brcmstb-waketimer: switch to rtc_register_device
In-Reply-To: <20180520202730.28172-1-alexandre.belloni@bootlin.com>
References: <20180520202730.28172-1-alexandre.belloni@bootlin.com>
Message-ID: <2ceb0348-b030-d584-2a20-0bc678a83b14@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/20/2018 01:27 PM, Alexandre Belloni wrote:
> Switch to devm_rtc_allocate_device/rtc_register_device.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
