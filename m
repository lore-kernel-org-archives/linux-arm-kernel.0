From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 20 May 2013 14:29:26 +0200
Subject: [PATCH 23/63] dmaengine: ste_dma40: Also report the number of
 logical channels
In-Reply-To: <1367591569-32197-24-git-send-email-lee.jones@linaro.org>
References: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
 <1367591569-32197-24-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZQityADLQTcyLBzDsTNA18ij3c94qiFYFXKBQDQNFasQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 3, 2013 at 4:32 PM, Lee Jones <lee.jones@linaro.org> wrote:

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

I'm missing Vinod's ACK on this before I can proceed with my
branch to ARM SoC.

Vinod?

Yours,
Linus Walleij
