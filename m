From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 16 Jun 2017 11:29:22 +0200
Subject: [PATCH v3 8/9] gpio: mvebu: Add support for the Armada 7K/8K SoCs
In-Reply-To: <b6357b8b179d66aab45548e693193054942e7dcc.1497281623.git-series.gregory.clement@free-electrons.com>
References: <cover.d003a5e862e6d732d901a61d1765a349c9a89eef.1497281623.git-series.gregory.clement@free-electrons.com>
 <b6357b8b179d66aab45548e693193054942e7dcc.1497281623.git-series.gregory.clement@free-electrons.com>
Message-ID: <CACRpkdYm7OYJ6ufzUtYqb6dJFEOMLdiw8zJ2Et1uEhxe7ARH9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 12, 2017 at 5:34 PM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:

> The Armada 7K and 8K SoCs use the same gpio controller as most of the
> other mvebu SoCs. However, the main difference is that the GPIO
> controller is part of a bigger system controller, and a syscon is used to
> control the overall system controller. Therefore, the driver needs to be
> adjusted to retrieve the regmap of the syscon to access registers, and
> account for the fact that registers are located at a certain offset
> within the regmap.
>
> This commit add the support of the syscon and introduce a new variant for
> this case.
>
> It was based on the preliminary work of Thomas Petazzoni.
>
> Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Patch applied.

Yours,
Linus Walleij
