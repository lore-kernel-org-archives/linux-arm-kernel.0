From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Fri, 1 Jun 2018 13:17:06 +0300
Subject: [PATCH v3] PCI: mediatek: Add system pm support for MT2712
In-Reply-To: <1527822270-30280-1-git-send-email-honghui.zhang@mediatek.com>
References: <1527822270-30280-1-git-send-email-honghui.zhang@mediatek.com>
Message-ID: <CAHp75VeBTmC=3nJ-t+OO9bp0mzJuTYsGBwi8fokT16bu2nE9RA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 1, 2018 at 6:04 AM,  <honghui.zhang@mediatek.com> wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>

> +#ifdef CONFIG_PM_SLEEP
> +static int mtk_pcie_suspend_noirq(struct device *dev)

__maybe_unused

-- 
With Best Regards,
Andy Shevchenko
