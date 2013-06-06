From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 06 Jun 2013 10:28:32 -0600
Subject: [PATCH] ARM: tegra: add basic SecureOS support
In-Reply-To: <51B0667D.30801@nvidia.com>
References: <1370503687-17767-1-git-send-email-acourbot@nvidia.com>
 <1740292.8Sz57ytBcM@flatron> <51B0667D.30801@nvidia.com>
Message-ID: <51B0B8B0.3050503@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/2013 04:37 AM, Alex Courbot wrote:
> Hi Tomasz,
> 
> On 06/06/2013 07:17 PM, Tomasz Figa wrote:
...
>> I think this patch could be split into several patches:
>>   - add support for firmware
>>   - split reset function
>>   - add reset support using firmware.
> 
> Mmm possibly yes, but I wonder if that would not be too much splitting.
> Stephen?

That's probably fine. It might make bisection easier if there are
regressions.
