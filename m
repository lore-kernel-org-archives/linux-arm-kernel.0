From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 29 May 2017 10:10:28 +0200
Subject: [PATCH] gpio: mvebu: Select REGMAP_MMIO now that regmap is used
In-Reply-To: <20170524143206.9727-1-gregory.clement@free-electrons.com>
References: <20170524143206.9727-1-gregory.clement@free-electrons.com>
Message-ID: <CACRpkdYCbTp3YiHvxWrFsA49orywb1cMFcaDEew1AwjRG61Tpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 24, 2017 at 4:32 PM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:

> Since the commit "gpio: mvebu: switch to regmap for register access" the
> driver use the regmap. Explicitly select the REGMAP_MMIO symbol to fix
> build error.
>
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Patch applied.

Yours,
Linus Walleij
