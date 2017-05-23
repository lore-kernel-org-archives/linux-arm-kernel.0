From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 23 May 2017 11:21:54 +0200
Subject: [PATCH 4/6] gpio: mvebu: allow building driver for Armada 7K/8K
In-Reply-To: <ed816f275537bf4e0d4557ed53b685b4f3186605.1495210061.git-series.gregory.clement@free-electrons.com>
References: <cover.e10718b9c0f9fdd07327ae14e213be8da5b1f7ef.1495210061.git-series.gregory.clement@free-electrons.com>
 <ed816f275537bf4e0d4557ed53b685b4f3186605.1495210061.git-series.gregory.clement@free-electrons.com>
Message-ID: <CACRpkdZ-gA7Zy0S3md=dO6uJrVpX27uzSKu1ze9YLzJwpNM-iQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 19, 2017 at 6:09 PM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:

> The mvebu gpio driver can also be used on arm64 mvebu SoC such as the
> Armada 7K/8K. This commit allows to build the driver for them (when only
> ARCH_MVEBU is defined)
>
> Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Patch applied.

Yours,
Linus Walleij
