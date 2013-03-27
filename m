From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 27 Mar 2013 09:24:42 +0100
Subject: [PATCH V2 1/9] gpio: tegra: add gpio wakeup source handling
In-Reply-To: <1363060928-8981-1-git-send-email-josephl@nvidia.com>
References: <1363060928-8981-1-git-send-email-josephl@nvidia.com>
Message-ID: <CACRpkdbZgnrP-LeAhR7kgVCJoJchg_YWY00CurtDM-HrvPTtMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 12, 2013 at 5:02 AM, Joseph Lo <josephl@nvidia.com> wrote:

> This patch add the gpio wakeup source handling for the Tegra platform. It
> was be done by enabling the irq for the gpio in the gpio controller and
> enabling the bank irq of the gpio in the Tegra legacy irq controller when
> the system going to suspend.
>
> Based on the work by:
> Varun Wadekar <vwadekar@nvidia.com>
>
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
> V2:
> * no change

Hm?

I ACKed V1 just recently for passing through the Tegra tree anyway.

Yours,
Linus Walleij
