From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 4 Aug 2011 18:53:51 +0200
Subject: [PATCH V5 00/15] To use DMA generic APIs for Samsung DMA
In-Reply-To: <1311744697-10264-1-git-send-email-boojin.kim@samsung.com>
References: <1311744697-10264-1-git-send-email-boojin.kim@samsung.com>
Message-ID: <CACRpkdZvbH1O608n_aa_nVi-Onhmt0Ay6X1yCgBVNES4o9hTrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 27, 2011 at 7:31 AM, Boojin Kim <boojin.kim@samsung.com> wrote:

> This patchset adds support DMA generic APIs for Samsung DMA.

Patches look good to me,
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Are there any more users of the code in arch/arm/common/pl330.c?
Else I think next step should be to move that file to drivers/dma/
and optionally merge it with the other pl330.c file there.

Thanks!
Linus Walleij
