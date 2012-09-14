From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 14 Sep 2012 16:01:35 -0600
Subject: [PATCH v3 4/5] arm: mvebu: add DT information for GPIO banks
 on Armada 370 and XP
In-Reply-To: <1347551658-24449-5-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1347551658-24449-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1347551658-24449-5-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <5053A93F.5030505@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/13/2012 09:54 AM, Thomas Petazzoni wrote:
> The gpioX aliases are needed so that the driver can use
> of_alias_get_id() to get a 0-based number of the GPIO bank, which we
> then use to compute the base GPIO of the bank being probed. This is
> similar to what gpio-mxs.c is doing.

#interrupt-cells is missing from all the gpio nodes here too.
