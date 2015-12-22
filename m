From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 22 Dec 2015 11:23:26 +0100
Subject: [PATCH] pinctrl: mediatek: convert to arch_initcall
In-Reply-To: <1450412497-25872-1-git-send-email-djkurtz@chromium.org>
References: <1450412497-25872-1-git-send-email-djkurtz@chromium.org>
Message-ID: <CACRpkdbuL5Kjeqb-zJg9DmoxKzy7vphYgBTG-Ffh2i=UVH97ug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 18, 2015 at 5:21 AM, Daniel Kurtz <djkurtz@chromium.org> wrote:

> Move pinctrl initialization earlier in boot so that real devices can find
> their pctldev without probe deferring.
>
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>

I interpret the discussion as I should wait for a new version of this?

Or should it be applied?

Yours,
Linus Walleij
