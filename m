From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Mon, 20 Feb 2017 22:27:17 +0200
Subject: [PATCH v2 1/3] mtd: nand: Cleanup/rework the atmel_nand driver
In-Reply-To: <1487593718-20752-2-git-send-email-boris.brezillon@free-electrons.com>
References: <1487593718-20752-1-git-send-email-boris.brezillon@free-electrons.com>
 <1487593718-20752-2-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <CAHp75VdwQGP-qa0c0KQwrdpZmCGc3RuEsJ-E-XLbBzQSn4Yxcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 20, 2017 at 2:28 PM, Boris Brezillon
<boris.brezillon@free-electrons.com> wrote:

>  drivers/mtd/nand/atmel/nand-controller.c | 2269 +++++++++++++++++++++++++++
>  drivers/mtd/nand/atmel_nand.c            | 2479 ------------------------------

Does -M -C help you?
At least it would help reviewers

-- 
With Best Regards,
Andy Shevchenko
