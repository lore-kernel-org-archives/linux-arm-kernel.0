From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Tue, 11 Aug 2015 12:26:14 +0200
Subject: [PATCH v3 0/4] mfd: Improve DT binding docs for max77686 and
 max77802
In-Reply-To: <1438252327-28427-1-git-send-email-javier@osg.samsung.com>
References: <1438252327-28427-1-git-send-email-javier@osg.samsung.com>
Message-ID: <55C9CDC6.9030903@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Lee and Mark,

On 07/30/2015 12:32 PM, Javier Martinez Canillas wrote:
> Hello Lee,
> 
> This series contains some improvements for the Device Tree bindings of
> the Maxim MAX77686 and MAX77802 multi-function devices.
> 
> This is the third version of the series that addresses issues pointed
> out by Sergei Shtylyov and you.
> 
> Patch #1 changes the max77686 binding to not suggest using a deprecated
> property of the regulator DT binding.
> 
> Patch #2 changes the max77686 example to use a generic node name instead
> of the chip's name.
> 
> Patch #3 adds a DT binding for the mfd portion of the max77802 that was
> missing.
> 
> Patch #4 moves the regulator portion of the max77686 to the regulator's
> DT binding sub-directory since it is a better fit for this information.
> This fourth patch needs an ack from the regulator sub-system maintainer.
>

Any comments on this series?

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
