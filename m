From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 04 Sep 2014 13:37:27 -0600
Subject: [PATCH] ARM: tegra: Move AHB Kconfig to drivers/amba
In-Reply-To: <53FB7288.9050002@wwwdotorg.org>
References: <1406643934-16301-1-git-send-email-thierry.reding@gmail.com>
 <53D7C9EE.60503@wwwdotorg.org> <53FB7288.9050002@wwwdotorg.org>
Message-ID: <5408BF77.1020007@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/25/2014 11:29 AM, Stephen Warren wrote:
> On 07/29/2014 10:21 AM, Stephen Warren wrote:
>> On 07/29/2014 08:25 AM, Thierry Reding wrote:
>>> From: Thierry Reding <treding@nvidia.com>
>>>
>>> This will allow the Kconfig option to be shared among 32-bit and 64-bit
>>> ARM.
>>
>> This seems fine to me. I'd expect to apply it for 3.18, provided I get
>> an ack from Russell as drivers/amba maintainer (hence CCing him without
>> trimming the quote).
>
> Russell,
>
> Are you OK with this patch? If so, if you could ack it so I can apply
> it, that would be great.

Russell?
