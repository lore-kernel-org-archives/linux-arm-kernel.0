From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Apr 2013 13:20:20 +0200
Subject: [PATCH 21/32 v2] dmaengine: ste_dma40: Also report the number of
 logical channels
In-Reply-To: <20130424083944.GG17416@gmail.com>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <1366279934-30761-22-git-send-email-lee.jones@linaro.org>
 <20130424083944.GG17416@gmail.com>
Message-ID: <CACRpkdaANF-ZA2wbfMdFcZ-4M0mAnRoJu_hZ07X75Vg_J5LiPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 24, 2013 at 10:39 AM, Lee Jones <lee.jones@linaro.org> wrote:

> dmaengine: ste_dma40: Also report the number of logical channels
>
> Now we know the total of physical and logical channels, we may as
> well report them within the information log.
>
> Before:
> dma40 dma40.0: hardware revision: 3 @ 0x801c0000 with 8 physical channels
>
> After:
> <as above ...> and 256 logical channels
>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Dan Williams <djbw@fb.com>
> Cc: Per Forlin <per.forlin@stericsson.com>
> Cc: Rabin Vincent <rabin@rab.in>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
