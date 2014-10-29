From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 29 Oct 2014 09:30:07 +0100
Subject: [PATCH] pinctrl: at91: fix compilation
In-Reply-To: <1414522686-5755-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1414522686-5755-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <CACRpkdZ2+-H1DYD8zQeLZK3MAtQkhcOzm6zxt_JO4Uq2Sjza5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 28, 2014 at 7:58 PM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:

> Add macros introduced by 4334ac2db2be9e278c95fd15260c1f49f698ffc5 that
> were missed when copying the header.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

I squashed this into the offending commit.

Yours,
Linus Walleij
