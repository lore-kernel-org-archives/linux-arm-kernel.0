From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 23 Oct 2015 11:23:51 +0100
Subject: [PATCH 06/19] input: tegra-kbc: enable support for the standard
 "wakeup-source" property
In-Reply-To: <20151023063946.GA38047@dtor-ws>
References: <1445422216-29375-1-git-send-email-sudeep.holla@arm.com>
 <1445422216-29375-7-git-send-email-sudeep.holla@arm.com>
 <20151023063946.GA38047@dtor-ws>
Message-ID: <562A0AB7.3080607@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 23/10/15 07:39, Dmitry Torokhov wrote:
> On Wed, Oct 21, 2015 at 11:10:03AM +0100, Sudeep Holla wrote:
>> Though the mmc core driver should/will continue to support the legacy
>> "nvidia,wakeup-source" property to enable SDIO as the wakeup source, we
>> need to add support for the new standard property "wakeup-source".
>>
>> This patch adds support for "wakeup-source" property in addition to the
>> existing "nvidia,wakeup-source" property.
>>
>> Cc: Laxman Dewangan <ldewangan@nvidia.com>
>> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> Cc: Thierry Reding <thierry.reding@gmail.com>
>> Cc: linux-input at vger.kernel.org
>> Cc: linux-tegra at vger.kernel.org
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>
> Applied, thank you.
>

Thanks, but I think I sent out a old copy which had unrelated commit
message because of copy-paste. *Sorry for that*. Can you update it
something like:

"
Though the tegra-kbc driver should/will continue to support the legacy
"nvidia,wakeup-source" property to enable keyboard as the wakeup source,
we need to add support for the new standard property "wakeup-source".

This patch adds support for "wakeup-source" property in addition to the
existing "nvidia,wakeup-source" property.
"
-- 
Regards,
Sudeep
