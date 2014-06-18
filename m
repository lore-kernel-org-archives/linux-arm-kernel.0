From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Wed, 18 Jun 2014 13:07:30 +0300
Subject: [PATCH v4 1/4] of: Add NVIDIA Tegra XUSB pad controller binding
In-Reply-To: <53A06BD6.40608@wwwdotorg.org>
References: <1403006877-19850-1-git-send-email-thierry.reding@gmail.com>
 <53A06BD6.40608@wwwdotorg.org>
Message-ID: <53A164E2.7050407@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/06/14 19:24, Stephen Warren wrote:
> On 06/17/2014 06:07 AM, Thierry Reding wrote:
>> From: Thierry Reding <treding@nvidia.com>
>>
>> This patch adds the device tree binding documentation for the XUSB pad
>> controller found on NVIDIA Tegra SoCs. It exposes both pinmuxing and PHY
>> capabilities.
>
> Thanks. I'll wait for a Tested-by from Mikko and an Acked-by from Linus
> before taking this series.
>

With or without negation added to group_get (see reply to 2/4), the series:

Tested-by: Mikko Perttunen <mperttunen@nvidia.com>
