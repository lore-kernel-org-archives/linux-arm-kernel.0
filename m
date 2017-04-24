From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 24 Apr 2017 11:15:24 +0200
Subject: [PATCH v5 1/4] gpio: mvebu: Add limited PWM support
In-Reply-To: <20170421111952.54978e80@free-electrons.com>
References: <20170409180931.4884-1-ralph.sennhauser@gmail.com>
 <20170409180931.4884-2-ralph.sennhauser@gmail.com>
 <20170412163128.5c985a26@free-electrons.com>
 <20170412151932.GE7023@lunn.ch> <20170421111952.54978e80@free-electrons.com>
Message-ID: <CACRpkdYeJkc8g0A6TXF3NO=jCZZvVpQ4kTPHg5=BriHbpN_-9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 21, 2017 at 11:19 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:

> I clearly don't want to block this, but I believe this is a very good
> illustration of why stable DT bindings simply don't work. We are
> realizing here that having each GPIO bank represented as a separate DT
> node doesn't work, because this blinking functionality is not per GPIO
> bank, but global to all GPIO banks.
>
> I am totally fine with compromise, and having things simple first, and
> extend them later if needed. But this stable DT binding rule makes this
> quite impossible: what is a compromise today might put you in big
> troubles tomorrow.

Really "stable bindings" I never believed in. It's just a pipe dream.

Well they might become stable when the system is "finished"
whenever that happens.

I think a better rationale is that of the IETF:
"rough consensus and running code", make deployed DTs work,
if they are not deployed, or only getting deployed together with the
kernel, changing the bindings are not a problem.

Yours,
Linus Walleij
