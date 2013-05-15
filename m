From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 15 May 2013 18:54:18 +0200
Subject: [PATCH 07/39] dmaengine: ste_dma40: Only use addresses passed as
 configuration information
In-Reply-To: <1368611522-9984-8-git-send-email-lee.jones@linaro.org>
References: <1368611522-9984-1-git-send-email-lee.jones@linaro.org>
 <1368611522-9984-8-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdY97uS_ckSqy=Ta0SDrXrGmtDB4eL28_ZZPN5j--emr5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 15, 2013 at 11:51 AM, Lee Jones <lee.jones@linaro.org> wrote:

> Addresses are passed in from the client's driver via the invocation of
> dmaengine_slave_config(), so there's no need to fetch them from platform
> data too, hardwired or otherwise. This is a great step forward, as it
> elevates a large burden from platform data in the way of a look-up
> table.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

This should be the case even without patch 5 & 6 so patch tentatively
applied.

Waiting for Vinod's ACK on this though.

Yours,
Linus Walleij
