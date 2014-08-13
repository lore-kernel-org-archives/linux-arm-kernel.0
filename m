From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 13 Aug 2014 18:58:45 +0200
Subject: [PATCH 6/6] ARM: dts: Add tps65090 FETs constraints
In-Reply-To: <20140813155122.GX17528@sirena.org.uk>
References: <1407861868-20097-1-git-send-email-javier.martinez@collabora.co.uk>
 <1407861868-20097-7-git-send-email-javier.martinez@collabora.co.uk>
 <20140812172552.GU17528@sirena.org.uk> <53EA61B9.2070805@collabora.co.uk>
 <20140812212757.GY17528@sirena.org.uk> <53EB4CA0.3010006@collabora.co.uk>
 <20140813122910.GQ17528@sirena.org.uk> <53EB6954.3040207@collabora.co.uk>
 <20140813155122.GX17528@sirena.org.uk>
Message-ID: <53EB9945.1020704@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark,

On 08/13/2014 05:51 PM, Mark Brown wrote:
> On Wed, Aug 13, 2014 at 03:34:12PM +0200, Javier Martinez Canillas wrote:
> 
>> Indeed. I'll change mmc_regulator_get_ocrmask() in MMC core then to use
>> regulator_can_change_voltage() to detect if the regulator is a fixed one
>> and call regulator_get_voltage() instead of list_voltage() in that case.
> 
>> Do you agree that this is the correct solution?
> 
> I would just fall back to get_voltage() if there are no voltages listed,
> that seems more robust.
> 

Great, thanks a lot for your suggestion and all the help.

Best regards,
Javier
