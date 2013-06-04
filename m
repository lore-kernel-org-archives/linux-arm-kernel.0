From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 4 Jun 2013 11:16:48 +0200
Subject: [PATCH v2] ARM: ux500: Allocate correct amount of memory for the
 u8540 in DT
In-Reply-To: <1370013351-7960-1-git-send-email-lee.jones@linaro.org>
References: <1370013351-7960-1-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkda9Ao6PpA_aOMghXjRMu54e3VPCa9VV+7Jj_Oa1NHqL2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 31, 2013 at 5:15 PM, Lee Jones <lee.jones@linaro.org> wrote:

> As it stands, the memory node in the u8540 Device Tree is ignored and
> memory is actually stipulated by the bootloader via ATAGS. ARM core
> architecture code then extracts the memory ATAG and inserts it into the
> Device Tree. In the u8540 the LittleKernel bootloader only stipulates
> 512MB of memory; however, the u8540 actually has 2GB. We're taking the
> responsibility to register the remainder from Device Tree here.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Patch applied to my ux500-devicetree branch.

Yours,
Linus Walleij
