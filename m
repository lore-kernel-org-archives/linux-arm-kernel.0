From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 May 2013 10:35:45 +0200
Subject: [PATCH 7/9] pinctrl: abx500: Specify failed sub-driver by ID
 instead of driver_data
In-Reply-To: <1368019749-19455-8-git-send-email-lee.jones@linaro.org>
References: <1368019749-19455-1-git-send-email-lee.jones@linaro.org>
 <1368019749-19455-8-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdYTBdtRkY1e-Qnzdk27wpKFkNKTtmXazjTDxTh1hmXmgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 8, 2013 at 3:29 PM, Lee Jones <lee.jones@linaro.org> wrote:

> If a sub-driver has not been specified correctly, there is a good chance
> that plat_id is NULL, hence using an attribute of plat_id in the error
> message is likely to not only fail the driver but Oops the kernel. Use
> the failed ID instead.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Good patch! Applied to the pinctrl fixes.

Yours,
Linus Walleij
