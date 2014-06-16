From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 16 Jun 2014 15:39:00 -0600
Subject: [PATCH v3 4/4] ARM: tegra: jetson-tk1: Add XUSB pad controller
In-Reply-To: <1402930623-28886-4-git-send-email-thierry.reding@gmail.com>
References: <1402930623-28886-1-git-send-email-thierry.reding@gmail.com>
 <1402930623-28886-4-git-send-email-thierry.reding@gmail.com>
Message-ID: <539F63F4.8030800@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/16/2014 08:57 AM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Assign lanes to the XUSB pads as used on the Jetson TK1.

This series looks OK to me.

Linus, are you OK with my taking it through the Tegra tree? If so, an
ack on patch 2/4 would be great. I expect there will be other series
(PCIe, SATA, XUSB drivers) that depend on this, so whichever tree it
goes through, we'll need to put it into a standalone topic branch for
various other trees to merge, or for other series to be applied on top of.
