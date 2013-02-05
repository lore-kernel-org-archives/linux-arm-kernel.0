From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 5 Feb 2013 15:31:21 +0100
Subject: [PATCH] pinctrl: sirf: replace of_gpio_simple_xlate by sirf
 specific of_xlate
In-Reply-To: <1359971614-18681-1-git-send-email-Barry.Song@csr.com>
References: <1359971614-18681-1-git-send-email-Barry.Song@csr.com>
Message-ID: <CACRpkdYvhBedZ+g4OtvfH11Pvq1kXOZQ7TtnNNyONYWC-ODEAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 4, 2013 at 10:53 AM, Barry Song <Barry.Song@csr.com> wrote:

> From: Barry Song <Baohua.Song@csr.com>
>
> the default of_gpio_simple_xlate() will make us fail while getting gpios
> bigger than 32 by of_get_named_gpio() or related APIs.
> this patch adds a specific of_xlate callback for sirf gpio_chip and fix
> the problem.
>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

Patch applied, hope this will be the last thing on fixes
for this cycle. I really need to get the last fixes to Torvalds now.

Yours,
Linus Walleij
