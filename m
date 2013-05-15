From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 15 May 2013 19:05:44 +0200
Subject: [PATCH 11/39] ARM: ux500: Remove unnecessary attributes from DMA
 channel request pdata
In-Reply-To: <1368611522-9984-12-git-send-email-lee.jones@linaro.org>
References: <1368611522-9984-1-git-send-email-lee.jones@linaro.org>
 <1368611522-9984-12-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdYLwywT0R7zyd2d=1bH+FajV=yopHrvTMpYRYF+4zkQDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 15, 2013 at 11:51 AM, Lee Jones <lee.jones@linaro.org> wrote:

> DMA data width and packet size information is only required at channel
> configuration time. Any information passed from platform data is passed
> directly to the DMA40 driver to use during channel allocation, but these
> pieces of information are subsequently ignored by the driver, so we may
> as well remove them.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Patch applied.

Yours,
Linus Walleij
