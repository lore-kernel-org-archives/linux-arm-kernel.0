From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 25 Nov 2015 16:03:19 +0100
Subject: [PATCH 1/2] ARM: mvebu: update v5 defconfig
In-Reply-To: <20151125143954.GD11384@lunn.ch>
References: <1448461036-16724-1-git-send-email-linus.walleij@linaro.org>
 <20151125143954.GD11384@lunn.ch>
Message-ID: <CACRpkdac7ZZ1MA0QO63SArOWzz-nGuHtKhGyGgyCyFQZYC-m=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2015 at 3:39 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> On Wed, Nov 25, 2015 at 03:17:16PM +0100, Linus Walleij wrote:
>>  CONFIG_SND_KIRKWOOD_SOC=y
>> -CONFIG_SND_KIRKWOOD_SOC_T5325=y
>
> Humm
>
> I think i will be sending a follow-up patch to re-enable these things.
> Add the missing dependencies.

Which do you mean? The symbol SND_KIRKWOOD_SOC_T5325
you removed in
commit 270a85c80c8645368f9768b120bd9eac4db23590
"ASoC: kirkwood: Remove unused drivers"

EXT4 does not need to be explicitly selected since EXT3 is provided
by EXT4 these days, I guess.

The rest I think are selected anyway so that is why they're not
in the reduced defconfigs.

Yours,
Linus Walleij
