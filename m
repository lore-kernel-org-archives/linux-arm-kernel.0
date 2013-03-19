From: marex@denx.de (Marek Vasut)
Date: Tue, 19 Mar 2013 22:27:21 +0100
Subject: [PATCH V4 6/9] ARM: mxs: Provide regulator to pwm-backlight
In-Reply-To: <1363719573-20926-7-git-send-email-achew@nvidia.com>
References: <1363719573-20926-1-git-send-email-achew@nvidia.com>
 <1363719573-20926-7-git-send-email-achew@nvidia.com>
Message-ID: <201303192227.21717.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Chew,

> The pwm-backlight driver now takes a mandatory regulator that is gotten
> during driver probe.  Initialize a dummy regulator to satisfy this
> requirement.
> 
> Signed-off-by: Andrew Chew <achew@nvidia.com>

Do we really need a mandatory regulator? Why can't it be optional?

Best regards,
Marek Vasut
