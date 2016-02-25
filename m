From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Feb 2016 10:36:35 +0100
Subject: [PATCH v5] Fix sun7i pin assignment for IRQ's
In-Reply-To: <1456129208-11490-1-git-send-email-henry@nitronetworks.nl>
References: <1456129208-11490-1-git-send-email-henry@nitronetworks.nl>
Message-ID: <CACRpkdbbOyp-=5n64QBhigtAebKV5BmFcnvFumjXv3f8bj8pbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 22, 2016 at 9:20 AM, Henry Paulissen <draakje197@gmail.com> wrote:

> After testing IRQ pins we found some bugs in the pinctrl declaration.
> Both PI* and PC* pins didn't work. PI* pins seemed to be connected
> to the wrong mux and PC* pins waren't working at all.
>
> Please note that the A20 soc manual is contradicting between version
> and even within the same document for both the PI and PC pins.
>
> Patch is based on testing with the hardware itself.
>
> Signed-off-by: Henry Paulissen <henry@nitronetworks.nl>
(...)
> Changes in v5:
>     Added a more detailed description.

Aha there is a v5. I took out the v4 and applied this
instead.

Yours,
Linus Walleij
