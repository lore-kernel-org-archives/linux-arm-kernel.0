From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 8 Feb 2013 12:22:32 +0530
Subject: [PATCHv3 4/4] arm: Add generic timer broadcast support
In-Reply-To: <20130207171748.GB28072@e106331-lin.cambridge.arm.com>
References: <1358183124-28461-1-git-send-email-mark.rutland@arm.com>
 <1358183124-28461-5-git-send-email-mark.rutland@arm.com>
 <5112C25F.6000508@wwwdotorg.org>
 <20130207100403.GD16987@e106331-lin.cambridge.arm.com>
 <511392A8.9010905@ti.com>
 <20130207171748.GB28072@e106331-lin.cambridge.arm.com>
Message-ID: <5114A0B0.2030103@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,

On Thursday 07 February 2013 10:47 PM, Mark Rutland wrote:

[..]

>>> I believe the patch below will fix this for Tegra and any other platforms where
>>> broadcast is required in low power states.
>>>
 From the Stephan's crash the issue is pretty clear and your patch make
sense. Some how I didn't manage to reproduce the issue on my board and
hence assumed everything is just fine. Will have a look at it later why
it didn't explode since it was so obvious.

Sorry for the noise.

Regards
Santosh
