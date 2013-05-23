From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 23 May 2013 21:00:51 +0200
Subject: [PATCH v2] mmc: mmci: Allow MMCI to request channels with
 information acquired from DT
In-Reply-To: <20130424155547.GA4623@gmail.com>
References: <1366801122-13302-1-git-send-email-lee.jones@linaro.org>
 <20130424155547.GA4623@gmail.com>
Message-ID: <CACRpkdbr4Lm4NGHzX4TTq4fYwFahwC82fQSBg_V=SGVKkqFdUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 24, 2013 at 5:55 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Currently, if DMA information isn't passed from platform data, then DMA
> will not be used. This patch allows DMA information obtained though Device
> Tree to be used as well.
>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Chris Ball <cjb@laptop.org>
> Cc: linux-mmc at vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

I've now tested this v2 version with device tree on Nomadik and
U300 and it works like a charm.
Tested-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
