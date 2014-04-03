From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 3 Apr 2014 17:48:02 +0200
Subject: [PATCH V2 05/19] mmc: mmci: Add DT bindings for feedback clock pin
In-Reply-To: <1396279100-2920-6-git-send-email-ulf.hansson@linaro.org>
References: <1396279100-2920-1-git-send-email-ulf.hansson@linaro.org>
 <1396279100-2920-6-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CACRpkdZtqY29bj=E89VqyOFZ8OXDGzfwWi3B5yhMB9hioUi_0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 31, 2014 at 5:18 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> The ST Micro variant supports the option of using a feedback clock signal in
> favor of the clockout pin when latching incoming signals on the data bus.
>
> Since this is matter of how pins are being routed we need to provide a new DT
> binding to be able to configure this through DT.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
