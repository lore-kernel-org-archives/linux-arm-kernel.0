From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 05 Mar 2013 11:23:23 -0700
Subject: [PATCH 01/10] gpio: tegra: add gpio wakeup source handling
In-Reply-To: <1362397186-5444-1-git-send-email-josephl@nvidia.com>
References: <1362397186-5444-1-git-send-email-josephl@nvidia.com>
Message-ID: <5136381B.6000300@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/04/2013 04:39 AM, Joseph Lo wrote:
> This patch add the gpio wakeup source handling for the Tegra platform. It
> was be done by enabling the irq for the gpio in the gpio controller and
> enabling the bank irq of the gpio in the Tegra legacy irq controller when
> the system going to suspend.

Grant, Linus, I assume there's a runtime dependency of the rest of this
series on this first patch. Can I get an ack to take this patch through
the Tegra tree? Thanks.
