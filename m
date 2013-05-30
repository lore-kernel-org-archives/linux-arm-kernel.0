From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 30 May 2013 10:56:07 +0200
Subject: [PATCH 32/39] ARM: ux500: Remove recently unused
 stedma40_xfer_dir enums
In-Reply-To: <1368611522-9984-33-git-send-email-lee.jones@linaro.org>
References: <1368611522-9984-1-git-send-email-lee.jones@linaro.org>
 <1368611522-9984-33-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdY1XOGPz19ftH2yZFG6-_Ww3bVqrsDvRZGk60gzuu0Maw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 15, 2013 at 11:51 AM, Lee Jones <lee.jones@linaro.org> wrote:

> We're now using the transfer direction definitions provided by the DMA
> sub-system, so the home-brew ones have become obsolete.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Tentatively applied, also missing Vinod's ACK on this, but it seems
it was implicitly ACKed in the discussion on patch 31.

Yours,
Linus Walleij
