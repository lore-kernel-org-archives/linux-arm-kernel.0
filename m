From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 11 Jun 2012 23:03:48 +0200
Subject: [PATCH 07/14] mfd: Initialise the AB8500 driver at core_initcall
 time
In-Reply-To: <1339428307-3850-8-git-send-email-lee.jones@linaro.org>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
 <1339428307-3850-8-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdY8aD1djSdPoeKYDdFVbf3E84ZWw2Q5CCLsPmoD66Hf7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 11, 2012 at 5:25 PM, Lee Jones <lee.jones@linaro.org> wrote:

> The AB8500 is soon to have its own IRQ domain. For this to be useful
> the driver needs to be initialised earlier in the boot sequence. Here
> we move initialisation forward from arch_initcall to core_initcall time.

I don't understand why using IRQ domain makes it necessary to
initialize the driver earlier in the init process. Please explain to me,
I need tutoring here.

Thanks,
Linus Walleij
