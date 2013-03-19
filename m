From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 19 Mar 2013 10:52:21 -0600
Subject: [PATCH V4 1/9] gpio: tegra: add gpio wakeup source handling
In-Reply-To: <1363594400-11663-2-git-send-email-josephl@nvidia.com>
References: <1363594400-11663-1-git-send-email-josephl@nvidia.com>
 <1363594400-11663-2-git-send-email-josephl@nvidia.com>
Message-ID: <514897C5.1000705@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/18/2013 02:13 AM, Joseph Lo wrote:
> This patch add the gpio wakeup source handling for the Tegra platform. It
> was be done by enabling the irq for the gpio in the gpio controller and
> enabling the bank irq of the gpio in the Tegra legacy irq controller when
> the system going to suspend.

Grant, Linus, are you OK with this change? Could I please get an Ack to
take it through the Tegra tree? Thanks.
