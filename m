From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 13 Sep 2012 09:09:15 -0600
Subject: [PATCH] arm: tegra: fixing compilation error
In-Reply-To: <1347513385-14158-1-git-send-email-vbyravarasu@nvidia.com>
References: <1347513385-14158-1-git-send-email-vbyravarasu@nvidia.com>
Message-ID: <5051F71B.6030604@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/12/2012 11:16 PM, Venu Byravarasu wrote:
> As usb_phy.h got moved from mach to include/linux/usb
> and renamed as tegra_usb_phy.h, correcting it in the include
> path.

This should no longer be necessary assuming there's a new linux-next today.

(Note that I did point out this issue on our internal mailing list; are
you not subscribed to that?)
