From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Jun 2015 14:10:24 +0200
Subject: [PATCH 25/34] pinctrl: mvebu: armada-xp: add spi1 function
In-Reply-To: <1433868446-11028-26-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1433868446-11028-26-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <CACRpkdZW7Xi1gMCgi33v0BZ00xAvJLN1dN=RX5JJYgeCGd-7CQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 9, 2015 at 6:47 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:

> The latest Armada XP datasheet documents that some of the MPP pins can
> be used to access the second SPI bus, labelled 'spi1'. This commit
> adds the corresponding pins in the pinctrl driver and its DT binding
> documentation.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Patch applied.

Yours,
Linus Walleij
