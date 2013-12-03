From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 3 Dec 2013 15:13:49 +0100
Subject: [RFC part3 PATCH 2/2] ARM64 / clocksource: Use
 arch_timer_acpi_init()
In-Reply-To: <529DE21E.4080707@linaro.org>
References: <1386069328-22502-1-git-send-email-hanjun.guo@linaro.org>
 <1386069328-22502-3-git-send-email-hanjun.guo@linaro.org>
 <CACRpkdYeMOMQzDn5=XpDg7X9L_zMZczGg-5SBA8q_WvwFPnH7A@mail.gmail.com>
 <529DE21E.4080707@linaro.org>
Message-ID: <CACRpkdZWELp1u=O=gSGZhaxQ2oTMu_jXuJb43snrr-tdYW9XAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 3, 2013 at 2:52 PM, Hanjun Guo <hanjun.guo@linaro.org> wrote:

> I will introduce has_arch_timer_node() as you said and use
> it as follows:
>
> if (has_arch_timer_node())
> clocksource_of_init();
> esle
> arch_timer_acpi_init(); /* try ACPI way */
>
> Is this make sense to you?

Sure, go head.

Thanks,
Linus Walleij
