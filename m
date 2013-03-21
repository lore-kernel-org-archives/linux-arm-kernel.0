From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 21 Mar 2013 14:01:54 -0600
Subject: [PATCH V4 8/9] ARM: tegra: Provide regulator to pwm-backlight
In-Reply-To: <1363719573-20926-9-git-send-email-achew@nvidia.com>
References: <1363719573-20926-1-git-send-email-achew@nvidia.com>
 <1363719573-20926-9-git-send-email-achew@nvidia.com>
Message-ID: <514B6732.7020107@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/19/2013 12:59 PM, Andrew Chew wrote:
> The pwm-backlight driver now takes a mandatory regulator that is gotten
> during driver probe.  Initialize a dummy regulator to satisfy this
> requirement.

I assume these patches will get merged through the PWM tree? If so,
Acked-by: Stephen Warren <swarren@nvidia.com>
