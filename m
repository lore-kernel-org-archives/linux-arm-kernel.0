From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 3 May 2013 22:48:20 +0200
Subject: [PATCH 22/63] dmaengine: ste_dma40: Move rev error-check up to
 revision acquisition
In-Reply-To: <1367591569-32197-23-git-send-email-lee.jones@linaro.org>
References: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
 <1367591569-32197-23-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdb7KFfNTZNwzyvh75k1cbjpxfSrxDW9cchM7cfUK3dmEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 3, 2013 at 4:32 PM, Lee Jones <lee.jones@linaro.org> wrote:

> At the moment we fetch the hardware revision, then do some stuff, then
> check whether the revision is correct and return in error if it's not.
> Well we may as well check it as soon as we know what it is, so let's
> move the check right up underneath where we acquire the version.
>
> Acked-by: Vinod Koul <vnod.koul@intel.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied to my ux500-dm40 branch.

(Notice I didn't apply 20 and 21 so now I'm screwing around.)

Thanks!
Linus Walleij
