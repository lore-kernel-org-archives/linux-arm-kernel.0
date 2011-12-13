From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 13 Dec 2011 12:54:55 +0100
Subject: [PATCH] dmaengine/dw_dmac: Add support for device_prep_dma_sg
In-Reply-To: <1323766064-13425-1-git-send-email-pratyush.anand@st.com>
References: <1323766064-13425-1-git-send-email-pratyush.anand@st.com>
Message-ID: <CACRpkdakPexKdxfkYociEsie2TWDdK60-gbm71D64tyrZ3HT0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 13, 2011 at 9:47 AM, Pratyush Anand <pratyush.anand@st.com> wrote:

> Memory to memory copy with scatter gather option has been implemented in
> this patch. Driver can manage even if number of nodes in src and dst
> list is different.
>
> Signed-off-by: Pratyush Anand <pratyush.anand@st.com>

Looks good to me.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
