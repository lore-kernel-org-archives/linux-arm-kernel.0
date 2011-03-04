From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 4 Mar 2011 17:35:01 +0000
Subject: [PATCH v5 REPOST 0/5] ARM: omap[34]: Thumb-2 compatibility fixes
In-Reply-To: <1299252837-18074-1-git-send-email-dave.martin@linaro.org>
References: <1299252837-18074-1-git-send-email-dave.martin@linaro.org>
Message-ID: <AANLkTimz0Ko9GFtLTcBQVV_c2DAPU5XhV47xT+R9Q7mv@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 4, 2011 at 3:33 PM, Dave Martin <dave.martin@linaro.org> wrote:
> This set of patches, along with some other patches under
> discussion on alkml, should enable omap3 and omap4 kernels to be
> built with CONFIG_THUMB2_KERNEL.
>
> This patch set builds on recent cleanup done by the omap
> maintainers.
>
> At least some of this code definitely works, most features have
> been tested successfully. ?Further testing, especially of Thumb-2
> behaviour, is still welcome.
>
> In particular, I still have no Ack/Tested-by on the following
> patches, so it would be great if anyone who has an opportunity
> to do a final review / re-test can do so.
>
> ?* ARM: omap3: Convert END() to ENDPROC() for correct linkage with CONFIG_THUMB2_KERNEL
> ?* ARM: omap3: Thumb-2 compatibility for sram34xx.S
> ?* ARM: omap3: Thumb-2 compatibility for sleep34xx.S

Following up on this, it looks like I have some locally-recorded acks
which didn't make it into my posting ...

The one patch I currently have no feedback on is this one:

  * ARM: omap4: Provide do_wfi() for Thumb-2

Cheers
---Dave
