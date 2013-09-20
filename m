From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 20 Sep 2013 22:55:33 +0200
Subject: [PATCH 03/26] clk: nomadik: declare OF clock provider
In-Reply-To: <1379526839-14798-4-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1379526839-14798-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1379526839-14798-4-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <CACRpkdax_csU5xMUzi-ut+g0Q2Ko8uKvb+dS9=MudouEJgJBMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 18, 2013 at 7:53 PM, Sebastian Hesselbarth
<sebastian.hesselbarth@gmail.com> wrote:

> Common clock framework allows to register clock providers to get called
> on of_clk_init() by using CLK_OF_DECLARE. This converts nomadik clock
> provider to make use of it and get rid of the mach specific clk init
> call. As clocks require system reset controller base address to be
> initialized each clock driver checks src_base and calls new
> nomadik_src_init if required.
>
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Looks like a good idea!
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
