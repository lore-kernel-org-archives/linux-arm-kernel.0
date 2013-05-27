From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 27 May 2013 13:34:09 +0200
Subject: [PATCH 5/6] ARM: ux500: Set eMMC and WLAN card slot as
 non-removable
In-Reply-To: <1369314830-3727-6-git-send-email-ulf.hansson@stericsson.com>
References: <1369314830-3727-1-git-send-email-ulf.hansson@stericsson.com>
 <1369314830-3727-6-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <CACRpkdbyQwbhoVt0ZU6TBeBtUw7OZQtrNP28B060DJGs5jzDWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 23, 2013 at 3:13 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:

> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> For several reasons, the mmc protocol layer expects devices
> being non-removable to use MMC_CAP_NONREMOVABLE, so then we
> adapt to this expectation.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Patch applied for ux500-core.

On the DT boot path this has the same problems and comments
as patches 3 & 4.

Yours,
Linus Walleij
