From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 8 Sep 2017 14:54:20 +0200
Subject: [PATCH] gpio: xgene-sb: Tidy up fwnode usage
In-Reply-To: <2ccfa46003fb5cf5970dc5cd8771953d375fed77.1503594687.git.robin.murphy@arm.com>
References: <2ccfa46003fb5cf5970dc5cd8771953d375fed77.1503594687.git.robin.murphy@arm.com>
Message-ID: <CACRpkdbdL5OrfWAJyrC_BCmfTWJC=r4oGzzssmCPt96b_Q=Agg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 24, 2017 at 7:24 PM, Robin Murphy <robin.murphy@arm.com> wrote:

> Since f94277af03ea ("of/platform: Initialise dev->fwnode appropriately"),
> of_platform_device_create() already initialises dev->fwnode to that of
> the appropriate device_node, so within the driver we shouldn't need to
> care whether we probed via DT or ACPI.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>
> Not tested, just an opportunity I happened to spot whilst looking
> at something else.

No replies so applied for v4.15 (next merge window).

Yours,
Linus Walleij
