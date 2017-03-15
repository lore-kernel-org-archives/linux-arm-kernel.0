From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 15 Mar 2017 10:15:53 +0100
Subject: [PATCH 1/2] ARM: dts: add SDC2 and SDC4 to the MSM8660 family
In-Reply-To: <20170306143542.GY25384@codeaurora.org>
References: <20170306080029.3422-1-linus.walleij@linaro.org>
 <20170306143542.GY25384@codeaurora.org>
Message-ID: <CACRpkda+pJm_A=yP_QGgW+T8VMDmOpRb1vQzoG9EVzNxkZf5zg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 6, 2017 at 3:35 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 03/06, Linus Walleij wrote:

>> +                             bus-width       = <8>;
>> +                             max-frequency   = <48000000>;
>> +                             non-removable;
>
> Should things like non-removable or max-frequency be specified in
> the base dts? Those seem like board attributes.

I dropped non-removable, which is obviously a board attribute.

max-frequency in this case is a cap on how high the IP can go
in this (Qualcomm) variant, on this SoC. A board DTS may need
to override it pushing it downwards because of line characteristics.

Yours,
Linus Walleij
