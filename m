From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 21 Nov 2016 15:12:38 +0000
Subject: [PATCH 0/8] firmware: arm_scpi: add support for legacy SCPI
 protocol
In-Reply-To: <CAD0U-hK982V+kUArjVSG7pTs5CLpNsgJaC5t8aPg8XuoiMRU0A@mail.gmail.com>
References: <1478148731-11712-1-git-send-email-sudeep.holla@arm.com>
 <20161108145118.GR1041@n2100.armlinux.org.uk>
 <28decdc3-6b86-924f-d3c1-9873a8cfce77@arm.com>
 <20161108154038.GS1041@n2100.armlinux.org.uk>
 <20161108160625.GU1041@n2100.armlinux.org.uk>
 <fb4348a8-197c-2219-ff01-8716e2a0b955@arm.com>
 <20161108174622.GW1041@n2100.armlinux.org.uk>
 <CAD0U-hK982V+kUArjVSG7pTs5CLpNsgJaC5t8aPg8XuoiMRU0A@mail.gmail.com>
Message-ID: <0af5ded0-8ea9-2b11-e70e-dc33b9111905@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 21/11/16 15:04, Ryan Harkin wrote:

[...]

> Switching to u-boot won't solve any thermal sensor calibration problems.
>

Indeed. The board Russell had was one of those early ones which was not
calibrated properly. He is now able to use the 16.10 release after
calibration.

-- 
Regards,
Sudeep
