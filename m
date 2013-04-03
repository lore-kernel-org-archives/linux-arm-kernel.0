From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 3 Apr 2013 18:29:03 +0200
Subject: [PATCH V5 1/9] gpio: tegra: add gpio wakeup source handling
In-Reply-To: <1364901613-25080-2-git-send-email-josephl@nvidia.com>
References: <1364901613-25080-1-git-send-email-josephl@nvidia.com>
 <1364901613-25080-2-git-send-email-josephl@nvidia.com>
Message-ID: <CACRpkdYOLuUyBu7ER7hqLGZnAoYS0Z7XJ6LC2=ec3vxKzF1rqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 2, 2013 at 1:20 PM, Joseph Lo <josephl@nvidia.com> wrote:
> This patch ad
d the gpio wakeup source handling for the Tegra platform. It
> was be done by enabling the irq for the gpio in the gpio controller and
> enabling the bank irq of the gpio in the Tegra legacy irq controller when
> the system going to suspend.
>
> Based on the work by:
> Varun Wadekar <vwadekar@nvidia.com>
>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> V5:
> * no change
> V4:
> * no change
> V3:
> * no change
> V2:
> * no change

Shall I just apply this to the GPIO tree to stop these repetitive mails
from coming?

Yours,
Linus Walleij
