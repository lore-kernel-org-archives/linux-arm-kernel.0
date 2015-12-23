From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 23 Dec 2015 11:24:38 +0000
Subject: [PATCH 13/19] ARM: dts: tegra: replace legacy *,wakeup property
 with wakeup-source
In-Reply-To: <1445422216-29375-14-git-send-email-sudeep.holla@arm.com>
References: <1445422216-29375-1-git-send-email-sudeep.holla@arm.com>
 <1445422216-29375-14-git-send-email-sudeep.holla@arm.com>
Message-ID: <CAPKp9uZ1hMegdL6wTUT0ROGd5CzyrnfKWsSRShXNdwRcyZ4Pnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 21, 2015 at 11:10 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> Though the keyboard and other driver will continue to support the legacy
> "gpio-key,wakeup", "nvidia,wakeup-source" boolean property to enable the
> wakeup source, "wakeup-source" is the new standard binding.
>
> This patch replaces all the legacy wakeup properties with the unified
> "wakeup-source" property in order to avoid any futher copy-paste
> duplication.
>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Alexandre Courbot <gnurou@gmail.com>

Ping, do you prefer taking via your tree or should I send to armsoc
directly ?

--
Regards,
Sudeep
