From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 24 Apr 2014 17:32:33 -0300
Subject: [PATCH] ARM: imx6q: work around faulty PMU irq routing
In-Reply-To: <1398371029-21176-1-git-send-email-l.stach@pengutronix.de>
References: <1398371029-21176-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <CAOMZO5DjiZnOHL9t3GeqSGu7=zU5ajKSs4__aVBRM0eHdHa3JA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 24, 2014 at 5:23 PM, Lucas Stach <l.stach@pengutronix.de> wrote:
> The i.MX6 PMU has a design errata where the interrupts of all cores are
> wired together into a single irq line. To work around this we have to

Is there an erratum reference number for this, please?
