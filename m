From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 7 Apr 2017 12:16:22 +0200
Subject: [PATCH] pinctrl: at91-pio4: handle suspend to ram
In-Reply-To: <20170406133623.19160-1-alexandre.belloni@free-electrons.com>
References: <20170406133623.19160-1-alexandre.belloni@free-electrons.com>
Message-ID: <CACRpkdYFPhewV4NLNxxVkXCwuyoo3rgeLt0auErS47R=055FHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 6, 2017 at 3:36 PM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:

> When suspending to RAM, the power to the core is cut and the register
> values are lost. Save and restore more registers than just IMR.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Should this be tagged for stable?

Waiting for input from the AT91 maintainers here.

Yours,
Linus Walleij
