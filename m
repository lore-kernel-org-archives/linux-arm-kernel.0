From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Nov 2011 09:41:10 +0100
Subject: [PATCH] mfd: add #ifdef CONFIG_DEBUG_FS guard for
 ab8500_debug_resources
In-Reply-To: <1320890178.13074.1.camel@phoenix>
References: <1320890178.13074.1.camel@phoenix>
Message-ID: <CACRpkda1590n+2P5dt9RmmGwPt_WP-u=M3+pDMeO_+kQ_qNBjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 10, 2011 at 2:56 AM, Axel Lin <axel.lin@gmail.com> wrote:

> Fix below build warning if CONFIG_DEBUG_FS is disabled.
>
> ?CC ? ? ?drivers/mfd/ab8500-core.o
> drivers/mfd/ab8500-core.c:623: warning: 'ab8500_debug_resources' defined but not used
>
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks Axel!
Linus Walleij
