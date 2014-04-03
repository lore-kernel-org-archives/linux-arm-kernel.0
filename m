From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 3 Apr 2014 17:47:28 +0200
Subject: [PATCH V2 04/19] mmc: mmci: Add DT bindings for signal direction
In-Reply-To: <1396279100-2920-5-git-send-email-ulf.hansson@linaro.org>
References: <1396279100-2920-1-git-send-email-ulf.hansson@linaro.org>
 <1396279100-2920-5-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CACRpkdbmhvEfN11OuReoBPzetf4OA50rMRRXxO0pH-s0h1jksw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 31, 2014 at 5:18 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> Some variants have support for indicating the bus signal directions,
> which currently are configured through platform data.
>
> Add corresponding DT bindings to enable us to move away from using the
> platform data.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
