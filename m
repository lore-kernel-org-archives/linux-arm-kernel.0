From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 30 Mar 2015 12:25:16 +0200
Subject: [PATCH v3] Mediatek PMIC wrapper support
In-Reply-To: <1426587274-7810-1-git-send-email-s.hauer@pengutronix.de>
References: <1426587274-7810-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <CABuKBeLYQjx1+1=EnAN+MLQt4pxnfnezJTsHbC1pFDJkw2Mggw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-03-17 11:14 GMT+01:00 Sascha Hauer <s.hauer@pengutronix.de>:
> This series adds support for the PMIC wrapper found on MT8135 and
> MT8173 SoCs. This has been sent several times already as part of
> different series, this time broken out as a series only containing
> the wrapper code. No further compile time dependencies.

Applied , thank you.

>
> Changes since v2:
>
> - remove stray debug printk
> - change MODULE_LICENSE to GPL v2 as stated in the header
>
> Changes since v1:
>
> - Remove #define DEBUG
> - Remove PMIC specific register writes
> - Mention other SoCs which contain a PMIC wrapper aswell
>
> Sascha
>



-- 
motzblog.wordpress.com
