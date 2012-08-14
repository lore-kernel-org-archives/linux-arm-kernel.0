From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Aug 2012 10:40:46 +0200
Subject: [PATCH 03/22] ASoC: ab8500: Inform SoC Core that we have our own
 I/O arrangements
In-Reply-To: <1344527268-5964-4-git-send-email-lee.jones@linaro.org>
References: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
 <1344527268-5964-4-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdY9L_-RwV6xWV9ta+qubWce0ZH0+FXaCHkeaWRvSYUhKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 9, 2012 at 5:47 PM, Lee Jones <lee.jones@linaro.org> wrote:

> If codec->control_data is not populated SoC Core assumes we want to
> use regmap, which fails catastrophically, as we don't have one:
>
> Unable to handle kernel NULL pointer dereference at virtual address 00000080
> pgd = c0004000
> [00000080] *pgd=00000000
> Internal error: Oops: 17 [#1] PREEMPT SMP ARM
> Modules linked in:
> CPU: 1    Not tainted  (3.5.0-rc6-00884-g0b2419e-dirty #130)
> PC is at regmap_read+0x10/0x5c
> LR is at hw_read+0x80/0x90
> pc : [<c01a91b8>]    lr : [<c0216804>]    psr: 60000013
>
> CC: alsa-devel at alsa-project.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

No clue on this one, have to refer to Mark...

Linus Walleij
