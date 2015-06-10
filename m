From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Jun 2015 14:00:03 +0200
Subject: [PATCH 22/34] pinctrl: mvebu: armada-370: align spi1 clock pin
 naming
In-Reply-To: <1433868446-11028-23-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1433868446-11028-23-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <CACRpkdZGo2MxqicMVWzty92ZQK+1gjBmVXhXQ8n56B=URPK1gg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 9, 2015 at 6:47 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:

> Across all SoCs, even on Armada 370 for SPI0, the clock pin uses the
> 'sck' subname and not 'clk', so this commit adjusts the code and
> documentation accordingly.
>
> Since this commit only changes the subname, DT backward compatibility
> is not affected.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Patch applied.

Yours,
Linus Walleij
