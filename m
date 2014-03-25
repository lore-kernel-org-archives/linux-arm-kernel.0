From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 25 Mar 2014 22:45:48 +0100
Subject: [PATCH 16/20] ARM: ux500: Remove redundant board file for mmci
 platform data
In-Reply-To: <1395404057-27835-17-git-send-email-ulf.hansson@linaro.org>
References: <1395404057-27835-1-git-send-email-ulf.hansson@linaro.org>
 <1395404057-27835-17-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CACRpkdYm0RfWDrbNjq5TZOKoitqVLqdNRAYvHyc5w40ofrbwAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 21, 2014 at 1:14 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> Since all platform data has been transfered to DT, we don't need the
> container for the mmci platform data anymore. Remove the file and the
> corresponding references to it's data.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
