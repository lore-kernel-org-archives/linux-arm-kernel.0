From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 27 Oct 2015 13:34:44 +0100
Subject: [PATCH 18/19] ARM: dts: ste: replace legacy *,wakeup property
 with wakeup-source
In-Reply-To: <1445422216-29375-19-git-send-email-sudeep.holla@arm.com>
References: <1445422216-29375-1-git-send-email-sudeep.holla@arm.com>
 <1445422216-29375-19-git-send-email-sudeep.holla@arm.com>
Message-ID: <CACRpkdYNFa-R8-u8JXijsCDyY+RHo4ANp+Voz3PEn6b9hcCrzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 21, 2015 at 12:10 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:

> Though the keyboard and other driver will continue to support the legacy
> "gpio-key,wakeup", "linux,wakeup" boolean property to enable the wakeup
> source, "wakeup-source" is the new standard binding.
>
> This patch replaces all the legacy wakeup properties with the unified
> "wakeup-source" property in order to avoid any futher copy-paste
> duplication.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Are you sending this to ARM SoC or do I need to handle the
patch?

Yours,
Linus Walleij
