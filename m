From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 17 Dec 2015 08:52:56 +0900
Subject: [PATCH 16/19] ARM: dts: s5pv210: replace legacy *, wakeup property
 with wakeup-source
In-Reply-To: <1445422216-29375-17-git-send-email-sudeep.holla@arm.com>
References: <1445422216-29375-1-git-send-email-sudeep.holla@arm.com>
 <1445422216-29375-17-git-send-email-sudeep.holla@arm.com>
Message-ID: <CAJKOXPcRVPq+wU7=cPkQyqF2Z7dCc0samcHV9UgCYZbeStuCCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-10-21 19:10 GMT+09:00 Sudeep Holla <sudeep.holla@arm.com>:
> Though the keyboard and other driver will continue to support the legacy
> "gpio-key,wakeup", "linux,input-wakeup" boolean property to enable the
> wakeup source, "wakeup-source" is the new standard binding.
>
> This patch replaces all the legacy wakeup properties with the unified
> "wakeup-source" property in order to avoid any futher copy-paste
> duplication.
>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: linux-samsung-soc at vger.kernel.org
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  arch/arm/boot/dts/s5pv210-aquila.dts   | 4 ++--
>  arch/arm/boot/dts/s5pv210-goni.dts     | 4 ++--
>  arch/arm/boot/dts/s5pv210-smdkv210.dts | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
