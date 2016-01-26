From: robh@kernel.org (Rob Herring)
Date: Tue, 26 Jan 2016 16:02:55 -0600
Subject: [PATCH 1/6] mtd: augment the "arm,versatile-flash" bindings
In-Reply-To: <1453806725-4880-2-git-send-email-linus.walleij@linaro.org>
References: <1453806725-4880-1-git-send-email-linus.walleij@linaro.org>
 <1453806725-4880-2-git-send-email-linus.walleij@linaro.org>
Message-ID: <20160126220255.GA13707@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2016 at 12:12:00PM +0100, Linus Walleij wrote:
> The bindings for the "arm,versatile-flash" device was merged in
> commit 3ba7222ac992d24d09ccd0b55940b54849eef752
> "arm/versatile: Add device tree support" but was never used
> for anything.
> 
> Versatile flash chips are actually just standard CFI chips,
> but they have one or two bits in a system controller to control
> VPP and write protection. Let's use this compatible string in
> conjunction with "cfi-flash" to indicate that we have a
> normal CFI flash with some extra Versatile-specific protection.
> 
> Cc: devicetree at vger.kernel.org
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../devicetree/bindings/mtd/arm-versatile.txt        | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
