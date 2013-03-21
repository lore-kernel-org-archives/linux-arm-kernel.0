From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 21 Mar 2013 19:07:28 +0100
Subject: [PATCH 09/11] ARM: integrator-cp: convert use CLKSRC_OF for timer
 init
In-Reply-To: <1363820051-24428-10-git-send-email-robherring2@gmail.com>
References: <1363820051-24428-1-git-send-email-robherring2@gmail.com>
 <1363820051-24428-10-git-send-email-robherring2@gmail.com>
Message-ID: <CACRpkdbCcvjnL4g9iUJm+1dxs28VhGnc_ibyARZNVP3MFRmNmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 20, 2013 at 11:54 PM, Rob Herring <robherring2@gmail.com> wrote:

> From: Rob Herring <rob.herring@calxeda.com>
>
> Move the integrator-cp timer init to timer-sp.c and use CLKSRC_OF. There is
> no reason to use the aliases, so drop them from the init code.
>
> The integrator-cp timers are mistakenly called sp804 timers in the dts, but
> in fact they are not sp804 dual timers, but single timers with the same
> programming model. Fix the dts to reflect this.
>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>

Looks correct to me. Throw it into linux-next and I'll
test if it works too! :-)
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
