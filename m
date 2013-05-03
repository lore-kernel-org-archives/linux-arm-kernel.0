From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 3 May 2013 23:16:13 +0200
Subject: [PATCH 31/63] dmaengine: ste_dma40: Only use addresses passed as
 configuration information
In-Reply-To: <1367591569-32197-32-git-send-email-lee.jones@linaro.org>
References: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
 <1367591569-32197-32-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZgPs1i=Lna41di97jZ2h-=_XzfZXMN8z9QFa-U-Avxog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 3, 2013 at 4:32 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Addresses are passed in from the client's driver via the invocation of
> dmaengine_slave_config(), so there's no need to fetch them from platform
> data too, hardwired or otherwise. This is a great step forward, as it
> elevates a large burden from platform data in the way of a look-up
> table.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

I get uncertain at this point and need Vinod's ACK so I stop
applying patches here.

Please base further submissions on my ux500-dma40 branch to
avoid resending already applied patches, if possible. (Atleast
that make things convenient for me.)

Is it possible to move patches with hairy dependencies
toward the end of the series or something?

Yours,
Linus Walleij
