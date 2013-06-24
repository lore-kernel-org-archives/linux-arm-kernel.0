From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 25 Jun 2013 00:33:51 +0200
Subject: [RFC PATCH v2 07/12] dmaengine: PL08x: Add cyclic transfer support
In-Reply-To: <1371933764-24875-8-git-send-email-tomasz.figa@gmail.com>
References: <1371933764-24875-1-git-send-email-tomasz.figa@gmail.com>
 <1371933764-24875-8-git-send-email-tomasz.figa@gmail.com>
Message-ID: <CACRpkdZrZFZ0MDP8=CWp9gv+1R6GfEktkgWaLDgEgzgfqGXucA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 22, 2013 at 10:42 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:

> From: Alban Bedel <alban.bedel@avionic-design.de>
>
> Many audio interface drivers require support of cyclic transfers to work
> correctly, for example Samsung ASoC DMA driver. This patch adds support
> for cyclic transfers to the amba-pl08x driver.
>
> Signed-off-by: Alban Bedel <alban.bedel@avionic-design.de>
> [tfiga: Rebase and slightly beautify the original patch.]
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>

Looks good to me:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
