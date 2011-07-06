From: adrian.wenl@gmail.com (Lei Wen)
Date: Wed, 6 Jul 2011 14:54:39 +0800
Subject: [PATCH 3/4] MTD: pxa3xx_nand: enable multiple chip select support
In-Reply-To: <1309935216.3149.72.camel@sauron>
References: <1309319494-17951-1-git-send-email-leiwen@marvell.com>
	<1309771536-10597-4-git-send-email-leiwen@marvell.com>
	<1309935216.3149.72.camel@sauron>
Message-ID: <CALZhoSSJmcCxEtMXMtfsBKpeOJzqbAt56_RB_Vpqihhuk3Aw=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 6, 2011 at 2:53 PM, Artem Bityutskiy <dedekind1@gmail.com> wrote:
> The problem is that in this patch you change ?struct pxa3xx_nand_platform_data,
> and in the next patch you amend the platform data declarations, which means that
> the kernel will not compile between patches 3 and 4...

So... how about merge the patch 3 and 4 together?

>
> On Mon, 2011-07-04 at 02:25 -0700, Lei Wen wrote:
>> + ? ? ? ? ? ? ? dev_info(&info->pdev->dev, "There is no nand chip on cs %d!\n"
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? , info->cs);
>
> Nitpick - keep the comma at the first line.

Opps, sorry for this.

Thanks,
Lei
