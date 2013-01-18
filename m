From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 18 Jan 2013 20:39:19 +0100
Subject: [PATCH 1/2] ARM: ux500: Provide a link from AB8500 Pinctrl to the
 PRCMU
In-Reply-To: <1357919129-1928-1-git-send-email-lee.jones@linaro.org>
References: <1357919129-1928-1-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdb_E9tkaRTYMhgFhqBgwKZ2zXWNWh+0Pg7H_z3JNWLe4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 11, 2013 at 4:45 PM, Lee Jones <lee.jones@linaro.org> wrote:

> The AB8500 Pinctrl driver uses PRCMU register addresses to
> control Pinctrl related functions. For this to happen, the
> Pinctrl driver needs the PRCMU base to work from. We can do
> that using standard Open Firmware (of_*) function calls, but
> first we need a mechanism to gain access to the PRCMU
> device node. We're going to use a Phandle in this case.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Patch applied to the pinctrl tree (so as to be adjacent to
the patch altering the code).

Yours,
Linus Walleij
