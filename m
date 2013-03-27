From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 27 Mar 2013 09:25:44 +0100
Subject: [PATCH V3 1/9] gpio: tegra: add gpio wakeup source handling
In-Reply-To: <1363161683-20825-2-git-send-email-josephl@nvidia.com>
References: <1363161683-20825-1-git-send-email-josephl@nvidia.com>
 <1363161683-20825-2-git-send-email-josephl@nvidia.com>
Message-ID: <CACRpkdYbD+uepq7PuvMhXVychaekPHg=8aZFtSZGPKRjPqg_MA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 13, 2013 at 9:01 AM, Joseph Lo <josephl@nvidia.com> wrote:

> This patch add the gpio wakeup source handling for the Tegra platform. It
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
> ---
> V3:
> * no change
> V2:
> * no change

No patience whatsoever eh? :-)

Yours,
Linus Walleij
