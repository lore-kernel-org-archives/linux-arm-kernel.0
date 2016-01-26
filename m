From: akpm@linux-foundation.org (Andrew Morton)
Date: Tue, 26 Jan 2016 15:59:37 -0800
Subject: [PATCH v6 0/5] dma-mapping: Patches for speeding up allocation
In-Reply-To: <1452533428-12762-1-git-send-email-dianders@chromium.org>
References: <1452533428-12762-1-git-send-email-dianders@chromium.org>
Message-ID: <20160126155937.6a4e4165d1cf4e513d62e942@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 11 Jan 2016 09:30:22 -0800 Douglas Anderson <dianders@chromium.org> wrote:

> This series of patches will speed up memory allocation in dma-mapping
> quite a bit.

This is pretty much all ARM and driver stuff so I think I'll duck it. 
But I can merge it if nobody else feels a need to.

I saw a few acked-by/tested-by/etc from the v5 posting which weren't
carried over into v6 (might have been a timing race), so please fix
that up if there's an opportunity.

Regarding the new DMA_ATTR_ALLOC_SINGLE_PAGES hint: I suggest adding
"DMA_ATTR_ALLOC_SINGLE_PAGES is presently implemented only on ARM" to
the docs.  Or perhaps have a shot at implementing it elsewhere.

Typo in 4/5 changelog: "reqiurements"
