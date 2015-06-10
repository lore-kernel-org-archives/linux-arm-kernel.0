From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Jun 2015 11:08:12 +0200
Subject: [PATCH 11/34] pinctrl: mvebu: armada-{38x,39x,xp}: normalize
 naming of DRAM functions
In-Reply-To: <1433868446-11028-12-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1433868446-11028-12-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <CACRpkdaonSg0ftjxGP3-A5QMTJeNcBZTuhd9_MvahmSurwmAZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 9, 2015 at 6:47 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:

> This commit makes the dram functions naming (both the name and
> subname) consistent accross SoC, by using:
>
>   dram(vttctrl)
>   dram(deccerr)
>
> in all Marvell SoCs.
>
> Due to the change to the name, it changes the DT binding, but these
> functions are not used by any in-tree Device Tree file, and are very
> unlikely to be used by anyone.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Patch applied.

Yours,
Linus Walleij
