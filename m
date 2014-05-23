From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 23 May 2014 15:31:26 +0200
Subject: [PATCH 10/10] clk: versatile: add versatile OSC support
In-Reply-To: <1400620176-7239-11-git-send-email-robherring2@gmail.com>
References: <1400620176-7239-1-git-send-email-robherring2@gmail.com>
 <1400620176-7239-11-git-send-email-robherring2@gmail.com>
Message-ID: <CACRpkdbjAa6Y-EVwK=D9eiA6JoW+pgxtnHCsrZSTZOY5uozMpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 11:09 PM, Rob Herring <robherring2@gmail.com> wrote:

> From: Rob Herring <robh@kernel.org>
>
> Versatile platforms share the same OSC programming model as Integrator
> platforms. Add the necessary parameters and init functions for Versatile.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Mike Turquette <mturquette@linaro.org>
> ---
>  drivers/clk/versatile/Makefile         |  3 +--
>  drivers/clk/versatile/clk-integrator.c | 35 ++++++++++++++++++++++++++++++++--

So then this is a good opportunity to rename that file from clk-integrator.c
to something else, right? Usually we use "versatile" to refer to the
whole family of boards but other names are possible I guess.

Apart from that it looks good :-)

Yours,
Linus Walleij
