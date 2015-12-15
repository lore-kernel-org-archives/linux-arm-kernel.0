From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 15 Dec 2015 16:35:42 +0000
Subject: [PATCH 13/19] ARM: dts: tegra: replace legacy *,wakeup property
 with wakeup-source
In-Reply-To: <1445422216-29375-14-git-send-email-sudeep.holla@arm.com>
References: <1445422216-29375-1-git-send-email-sudeep.holla@arm.com>
 <1445422216-29375-14-git-send-email-sudeep.holla@arm.com>
Message-ID: <5670415E.6000208@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 21/10/15 11:10, Sudeep Holla wrote:
> Though the keyboard and other driver will continue to support the legacy
> "gpio-key,wakeup", "nvidia,wakeup-source" boolean property to enable the
> wakeup source, "wakeup-source" is the new standard binding.
>
> This patch replaces all the legacy wakeup properties with the unified
> "wakeup-source" property in order to avoid any futher copy-paste
> duplication.
>

Ping, do you prefer taking via your tree or should I send to armsoc
directly ?

-- 
Regards,
Sudeep
