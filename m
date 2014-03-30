From: marex@denx.de (Marek Vasut)
Date: Sun, 30 Mar 2014 19:41:52 +0200
Subject: [PATCH 0/8] i.MX6 PCIe binding change and MSI support
In-Reply-To: <1396025579-14344-1-git-send-email-l.stach@pengutronix.de>
References: <1396025579-14344-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <201403301941.52149.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, March 28, 2014 at 05:52:51 PM, Lucas Stach wrote:
> While working on MSI support for the i.MX6 PCIe host driver
> it has been discovered that the binding for this host controller
> is broken in many ways (refer to the patch descriptions for more
> info) and was introduced without proper discussion about what
> should/should not be in the binding.
> 
> This series fixes this and minimizes the difference of the
> i.MX6 binding to the common designware PCIe binding. I'm aware
> that this is a quite radical change, but I think it's justified
> to do this as long as there aren't many user of the old binding
> (most of the optional properties in the binding aren't even
> implemented).
> 
> Looking forward to your feedback.

Other but 2/8, which needs further discussion,

Reviewed-by: Marek Vasut <marex@denx.de>

Best regards,
Marek Vasut
