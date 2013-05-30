From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 30 May 2013 10:52:13 +0200
Subject: [PATCH 30/39] ARM: ux500: Replace ST-E's home-brew DMA direction
 definition with the generic one
In-Reply-To: <1368611522-9984-31-git-send-email-lee.jones@linaro.org>
References: <1368611522-9984-1-git-send-email-lee.jones@linaro.org>
 <1368611522-9984-31-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZfw9ACS9=Nx9NuQqca_cvrdYwNOSWfpigMU1x94goZcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 15, 2013 at 11:51 AM, Lee Jones <lee.jones@linaro.org> wrote:

> STEDMA40_*_TO_* direction definitions are identical in all but name to
> the pre-defined generic DMA_*_TO_* ones. Let's make things easy by not
> duplicating such things.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Vinod, I'm lacking your ACK on this patch, but have tentatively
queued it anyway. Maybe you missed it?

Yours,
Linus Walleij
