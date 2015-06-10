From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Jun 2015 10:52:09 +0200
Subject: [PATCH 02/34] pinctrl: mvebu: armada-370: fix spi0 pin description
In-Reply-To: <1433868446-11028-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1433868446-11028-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <CACRpkdae6H7Cdq2_da0pRVXecjpDWVcUuYZ=9gEngwXHV9AmCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 9, 2015 at 6:46 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:

> Due to a mistake, the CS0 and CS1 SPI0 functions were incorrectly
> named "spi0-1" instead of just "spi0". This commit fixes that.
>
> This DT binding change does not affect any of the in-tree users.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: <stable@vger.kernel.org> # v3.7+
> Fixes: 5f597bb2be57 ("pinctrl: mvebu: add pinctrl driver for Armada 370")

Patch applied.

Yours,
Linus Walleij
