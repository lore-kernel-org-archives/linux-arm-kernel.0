From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 31 May 2016 10:13:35 +0200
Subject: [PATCH] pinctrl: mediatek: fix dual-edge code defect
In-Reply-To: <1463815419-11719-1-git-send-email-hongkun.cao@mediatek.com>
References: <1463815419-11719-1-git-send-email-hongkun.cao@mediatek.com>
Message-ID: <CACRpkdYWEpVetL=YXs-FjaHUob6U6WjJspmiJYaGR8NPMjh6zA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 21, 2016 at 9:23 AM,  <hongkun.cao@mediatek.com> wrote:

> From: "hongkun.cao" <hongkun.cao@mediatek.com>
>
> When a dual-edge irq is triggered, an incorrect irq will be reported on
> condition that the external signal is not stable and this incorrect irq
> has been registered.
> Correct the register offset.
>
> Signed-off-by: hongkun.cao <hongkun.cao@mediatek.com>

Patch applied for fixes with Matthias' review tag.

Yours,
Linus Walleij
