From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Oct 2018 09:17:19 +0200
Subject: [PATCH V3 2/2] pinctrl: bcm: add Northstar driver
In-Reply-To: <20180926193103.21241-2-zajec5@gmail.com>
References: <20180926193103.21241-1-zajec5@gmail.com>
 <20180926193103.21241-2-zajec5@gmail.com>
Message-ID: <CACRpkdYpfunUSZSoiMTBoO3yQyas6g0s2uxbxovqXy9MRYiOLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 26, 2018 at 9:31 PM Rafa? Mi?ecki <zajec5@gmail.com> wrote:

> From: Rafa? Mi?ecki <rafal@milecki.pl>
>
> This driver provides support for Northstar mux controller. It differs
> from Northstar Plus one so a new binding and driver were needed.
>
> Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
> ---
> V2: Define more pins, groups, functions
>     Simplify ns_pinctrl_set_mux() as Northstar uses 1:1 mapping
> V3: Support 3 different bindings and different sets of pins, groups
>     and functions. This requires building arrays dynamically on init.

Patch applied.

Yours,
Linus Walleij
