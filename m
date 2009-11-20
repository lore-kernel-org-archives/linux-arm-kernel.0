From: dan.j.williams@intel.com (Dan Williams)
Date: Fri, 20 Nov 2009 00:00:31 -0700
Subject: [PATCH] Add COH 901 318 DMA block driver v5
In-Reply-To: <1258656557-5492-1-git-send-email-linus.walleij@stericsson.com>
References: <1258656557-5492-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <e9c3a7c20911192300q6f1c9361j87617fcf2f2a4118@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 19, 2009 at 11:49 AM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> This patch adds support for the ST-Ericsson COH 901 318 DMA block,
> found in the U300 series platforms. It registers a DMA slave for
> device I/O and also a memcpy slave for memcpy.
>
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> ---
> ChangeLog v4->v5
> - Change requested DMA pool memory type from GFP_ATOMIC to
> ?GFP_NOWAIT
> - Remove the prep_interrupt function altogether, inline it
> ?in the few places needed, simplifying the code overall.
> - implement the .is_tx_complete() function.
> ---

Applied to the 'next' branch of async_tx.git.

Thanks,
Dan
