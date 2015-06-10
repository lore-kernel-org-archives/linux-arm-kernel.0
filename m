From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Jun 2015 11:09:03 +0200
Subject: [PATCH 12/34] pinctrl: mvebu: armada-39x: normalize SATA present
 functionality naming
In-Reply-To: <1433868446-11028-13-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1433868446-11028-13-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <CACRpkdbOFdTL2zAYj+Edt6QkwjkK0RjchgvV0=eonmV3BS+OzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 9, 2015 at 6:47 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:

> This commit makes the naming of SATA related MPP functions consistent
> accross SoCs by adjusting the Armada 39x definition to use "prsnt"
> instead of "present".
>
> Since only the subnames are changed, the DT binding is not modified at
> all.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Patch applied.

Yours,
Linus Walleij
