From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 8 Feb 2013 12:18:40 +0530
Subject: [PATCHv3 4/4] arm: Add generic timer broadcast support
In-Reply-To: <5113DBAF.2050104@wwwdotorg.org>
References: <1358183124-28461-1-git-send-email-mark.rutland@arm.com>
 <1358183124-28461-5-git-send-email-mark.rutland@arm.com>
 <5112C25F.6000508@wwwdotorg.org>
 <20130207100403.GD16987@e106331-lin.cambridge.arm.com>
 <511392A8.9010905@ti.com> <5113DBAF.2050104@wwwdotorg.org>
Message-ID: <51149FC8.50902@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 07 February 2013 10:21 PM, Stephen Warren wrote:
> On 02/07/2013 04:40 AM, Santosh Shilimkar wrote:
[...]

>> Stephan,
>>
>> Do we have crash log seen on Tegra ? Which tegra CPUIDLE driver
>> is being used when crash is seen ?
>
> The crash log is below. It's simply because td->evt->broadcast is NULL
> because it wasn't ever set.
>
Thanks for the log. Its clear from the log that broadcast event wasn't
set.

Regards,
Santosh
