From: marex@denx.de (Marek Vasut)
Date: Thu, 28 Mar 2013 15:47:32 +0100
Subject: [PATCH V5 3/9] ARM: pxa: Provide regulator to pwm-backlight
In-Reply-To: <1364260913-25490-4-git-send-email-achew@nvidia.com>
References: <1364260913-25490-1-git-send-email-achew@nvidia.com>
 <1364260913-25490-4-git-send-email-achew@nvidia.com>
Message-ID: <201303281547.32895.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Chew,

> The pwm-backlight driver now takes a mandatory regulator that is gotten
> during driver probe.  Initialize a dummy regulator to satisfy this
> requirement.
> 
> Signed-off-by: Andrew Chew <achew@nvidia.com>
> Acked-by: Alexandre Courbot <acourbot@nvidia.com>

Looks reasonable. Add my

Reviewed-by: Marek Vasut <marex@denx.de>

Best regards,
Marek Vasut
