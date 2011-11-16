From: linkinjeon@gmail.com (NamJae Jeon)
Date: Wed, 16 Nov 2011 10:55:27 +0900
Subject: [PATCH 3/4] mmc: Logging neatening
In-Reply-To: <1321408236.9189.3.camel@Joe-Laptop>
References: <cover.1321398814.git.joe@perches.com>
 <d2c1a76fea1844ae7ac3e7e17183fb39df19178e.1321398814.git.joe@perches.com>
 <CAKYAXd8_mDF68PnEnpuZZQ+O8-QmrfRpP4jv+SpHDx1juTxFGQ@mail.gmail.com>
 <1321408236.9189.3.camel@Joe-Laptop>
Message-ID: <CAKYAXd8fki1HfFRuRyi4_HNLK6aiFM5NAbyKApgbGaaR=VOTEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/11/16 Joe Perches <joe@perches.com>:
> On Wed, 2011-11-16 at 10:48 +0900, NamJae Jeon wrote:
>
> [123K of untrimmed reply]
>
> If you wrote something, I didn't find it.
>

> -       dev_info(&pdev->dev, "DW MMC controller at irq %d, "
> -                "%d bit host data width, "
> -                "%u deep fifo\n",
> +       dev_info(&pdev->dev,
> +       "DW MMC controller at irq %d, %d bit host data width, %u deep fifo\n",
>                 irq, width, fifo_size);

I think that tab is needed this "DW MMC controller at irq ...." ?
