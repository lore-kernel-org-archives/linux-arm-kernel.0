From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 20 May 2012 23:15:07 +0200
Subject: [PATCH 09/18] regulator: ab8500: Split up probe() into manageable
 pieces
In-Reply-To: <1337262323-27692-10-git-send-email-lee.jones@linaro.org>
References: <1337262323-27692-1-git-send-email-lee.jones@linaro.org>
 <1337262323-27692-10-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbrL3WY2X-sbKk5cZ=mLCuYA=SBQ294ceaZ2PdA2Q4-Ag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2012 at 3:45 PM, Lee Jones <lee.jones@linaro.org> wrote:

> ab8500's probe() function is becoming quite large, so in the lead
> up to Device Tree enablement which will fork the thread of execution
> this patch splits it into 3 main areas; basic error checking will
> remain in probe(), but regulator register initialisation and regulator
> registration have been moved to their own functions which will
> be called in sequence by probe() and the DT equivalent.
>
> Cc: linux-kernel at vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks to Mark for review and merge,

Linus Walleij
