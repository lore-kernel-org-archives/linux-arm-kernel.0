From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 21 Mar 2013 18:51:29 +0100
Subject: [PATCH] pinctrl: mvebu: fix checking for SoC specific controls
In-Reply-To: <1363720062-21395-1-git-send-email-simon.guinot@sequanux.org>
References: <1363720062-21395-1-git-send-email-simon.guinot@sequanux.org>
Message-ID: <CACRpkda3XEB3akuedDzWLgtR0uRVgQY9vDQGoGgb6Ac2QejemA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 19, 2013 at 8:07 PM, Simon Guinot <simon.guinot@sequanux.org> wrote:

> This patch fixes a minor bug (probably due to a typo) while checking
> the SoC specific controls in mvebu_pinctrl_probe().
>
> Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>

Patch applied with Sebastian's ACK, thanks!

Yours,
Linus Walleij
