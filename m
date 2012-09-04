From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 4 Sep 2012 09:27:55 +0200
Subject: [PATCH] gpio: samsung: Update documentation
In-Reply-To: <1346603089-14122-1-git-send-email-sylvester.nawrocki@gmail.com>
References: <503D267A.2090406@gmail.com>
 <1346603089-14122-1-git-send-email-sylvester.nawrocki@gmail.com>
Message-ID: <CACRpkdbudOv9AvS1XuyPB+BZ63+Ymu5dhkBBWFCo2qYDV+jAmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 2, 2012 at 6:24 PM, Sylwester Nawrocki
<sylvester.nawrocki@gmail.com> wrote:

> Update Samsung GPIO API documentation to reflect removal of
> the s3c24xx specific gpio API. While at it, fix some typos.
>
> The notes on conversion from s3c2410_* functions to the gpiolib
> API are left here just in case there is any out of tree code that
> still needs to be converted.
>
> Signed-off-by: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Get the Samsung maintainers to apply this patch since they carry
the API changes.

Yours,
Linus Walleij
