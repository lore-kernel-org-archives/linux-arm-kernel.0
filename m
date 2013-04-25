From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Apr 2013 13:17:58 +0200
Subject: [PATCH 20/32] dmaengine: ste_dma40: Move rev error-check up to
 revision acquisition
In-Reply-To: <1366279934-30761-21-git-send-email-lee.jones@linaro.org>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <1366279934-30761-21-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdaEK9fkcqY1So9UdUeeyJbenve+XUyk8ra7ZWQPNhobdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 12:12 PM, Lee Jones <lee.jones@linaro.org> wrote:

> At the moment we fetch the hardware revision, then do some stuff, then
> check whether the revision is correct and return in error if it's not.
> Well we may as well check it as soon as we know what it is, so let's
> move the check right up underneath where we acquire the version.
>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Dan Williams <djbw@fb.com>
> Cc: Per Forlin <per.forlin@stericsson.com>
> Cc: Rabin Vincent <rabin@rab.in>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
