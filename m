From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 23 May 2017 11:16:52 +0200
Subject: [PATCH 2/6] gpio: mvebu: switch to regmap for register access
In-Reply-To: <d3d38eb9cec70544aeedcc76a29e3372ea5683e8.1495210061.git-series.gregory.clement@free-electrons.com>
References: <cover.e10718b9c0f9fdd07327ae14e213be8da5b1f7ef.1495210061.git-series.gregory.clement@free-electrons.com>
 <d3d38eb9cec70544aeedcc76a29e3372ea5683e8.1495210061.git-series.gregory.clement@free-electrons.com>
Message-ID: <CACRpkdb5MkLrp-vVZupsBHL4wkwWS2JVWk5DaTB1VSn9XHNYaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 19, 2017 at 6:09 PM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:

> From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>
> In order to be able to use this driver with the Armada 7K/8K SoCs, we
> need to use the regmap to access the registers. Indeed for these new SoCs,
> the gpio node will be part of a syscon.
>
> [gregory.clement at free-electrons.com:
>  - fixed merge conflcit from 4.10 to 4.12-rc1
>  - added a commit log]
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Patch applied.

Yours,
Linus Walleij
