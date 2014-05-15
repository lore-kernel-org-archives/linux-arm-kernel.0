From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 15 May 2014 12:42:34 -0600
Subject: [PATCH 7/7] ARM: tegra: Add the EC i2c tunnel to tegra124-venice2
In-Reply-To: <1397757570-19750-8-git-send-email-dianders@chromium.org>
References: <1397757570-19750-1-git-send-email-dianders@chromium.org>
 <1397757570-19750-8-git-send-email-dianders@chromium.org>
Message-ID: <53750A9A.8000808@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/17/2014 11:59 AM, Doug Anderson wrote:
> This adds the EC i2c tunnel (and devices under it) to the
> tegra124-venice2 device tree.

Did the MFD patches at the start of this series get applied yet? I was
hoping to apply this one patch to the Tegra tree for 3.16, and that
needs to happen by tomorrow morning at the latest since -rc6 is looming
fast. However, I'm holding off until the rest of the series is applied
to the MFD tree so I can be sure the DT binding is accepted first...
