From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 31 Jul 2017 15:39:06 +0200
Subject: [PATCH] ARM: tegra: Select appropriate DMA options for LPAE
In-Reply-To: <1499178545.12420.4.camel@paulk.fr>
References: <20170424225946.19425-1-contact@paulk.fr>
 <1499178545.12420.4.camel@paulk.fr>
Message-ID: <CACRpkdYqWesH6nRJboUuF1w512f9nSjce8X4G1dRP9rKNVXY0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 4, 2017 at 4:29 PM, Paul Kocialkowski <contact@paulk.fr> wrote:
> On Tue, 2017-04-25 at 00:59 +0200, Paul Kocialkowski wrote:
>> This automatically selects options for zone DMA and 64 bit DMA addresses
>> when LPAE is enabled on ARM Tegra platforms. These options are required
>> for proper operation with LPAE enabled.
>
> Bumping this one since it did not get any review yet.
>
> It should be a good candidate for inclusion now that the merge window is open.

If you don't get any reply still, send it to the ARM SoC maintainers
directly at arm at kernel.org and request it to be applied.

Yours,
Linus Walleij
