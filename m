From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Jun 2015 13:43:18 +0200
Subject: [PATCH 17/34] pinctrl: mvebu: armada-{370,
 375}: normalize PCIe pins
In-Reply-To: <1433868446-11028-18-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1433868446-11028-18-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <CACRpkdaNmdYy0kucyrgOdncbNFsDkUojyNAA4Jb0Yet0HNJQ4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 9, 2015 at 6:47 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:

> This commit normalizes the naming of PCIe pins to use 'rstout' instead
> of 'rstoutn' or 'rst-out'.
>
> Since only the subnames are changed, DT compatibility is not affected.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Patch applied.

Yours,
Linus Walleij
