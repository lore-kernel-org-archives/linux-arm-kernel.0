From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Jun 2015 10:51:17 +0200
Subject: [PATCH 01/34] pinctrl: mvebu: armada-38x: fix PCIe functions
In-Reply-To: <1433868446-11028-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1433868446-11028-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <CACRpkdbsp=L23SwypwAU=pu1eeVjeS7kVUqQn-zWnKdHOq7buQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 9, 2015 at 6:46 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:

> A new revision of the Marvell Armada 38x hardware datasheet unveiled
> that the definition of some of the PCIe functions were not
> correct. This commit fixes the pinctrl driver accordingly.
>
> Some PCIe functions simply do not exist, some of the PCIe functions in
> fact were corresponding to other functions, and some PCIe functions
> have been added.
>
> Note: the seemingly unrelated removal of spi(cs2) on MPP47 is related:
> this function is in fact implemented on MPP43, instead of a PCIe
> function.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: <stable@vger.kernel.org> # v3.15+
> Fixes: ca6d9a084b56f ("pinctrl: mvebu: add pin-muxing driver for the Marvell Armada 380/385")

Patch applied.

Yours,
Linus Walleij
