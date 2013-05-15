From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 15 May 2013 19:04:27 +0200
Subject: [PATCH 10/39] dmaengine: ste_dma40: Correct copy/paste error
In-Reply-To: <1368611522-9984-11-git-send-email-lee.jones@linaro.org>
References: <1368611522-9984-1-git-send-email-lee.jones@linaro.org>
 <1368611522-9984-11-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbQaB9adaCb6FR3XAMMK2AtDdzKfNb0WZZ8Gm5yQBiuVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 15, 2013 at 11:51 AM, Lee Jones <lee.jones@linaro.org> wrote:

> 'struct stedma40_half_channel_info's header comment says that it's
> called 'struct stedma40_chan_cfg'. Let's straighten that out.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Patch tentatively applied waiting for Vinod's ACK.

Yours,
Linus Walleij
