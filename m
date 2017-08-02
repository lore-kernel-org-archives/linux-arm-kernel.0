From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 2 Aug 2017 10:45:07 +0200
Subject: [PATCH] pinctrl: samsung: Remove unneeded local variable
 initialization
In-Reply-To: <1500399808-6580-1-git-send-email-krzk@kernel.org>
References: <1500399808-6580-1-git-send-email-krzk@kernel.org>
Message-ID: <CACRpkdbMBgOad3Vidccu46GhF9ccYwGqPjE19N_AvnRn0S_qMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 18, 2017 at 7:43 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:

> Two local variables (shift and reg_con) were initialized to unused
> values - they were overwritten just few lines after.  Getting rid of
> this unused initialization allows dropping other variables and
> compacting slightly the code.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Looks good to me, I expect to get this from you in a pull request.

Yours,
Linus Walleij
