From: stern@rowland.harvard.edu (Alan Stern)
Date: Sat, 16 Nov 2013 13:12:59 -0500 (EST)
Subject: [PATCH 27/31] USB: EHCI: tegra: use reset framework
In-Reply-To: <1384548866-13141-28-git-send-email-swarren@wwwdotorg.org>
Message-ID: <Pine.LNX.4.44L0.1311161312380.8119-100000@netrider.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 15 Nov 2013, Stephen Warren wrote:

> From: Stephen Warren <swarren@nvidia.com>
> 
> Tegra's clock driver now provides an implementation of the common
> reset API (include/linux/reset.h). Use this instead of the old Tegra-
> specific API; that will soon be removed.
> 
> Cc: treding at nvidia.com
> Cc: pdeschrijver at nvidia.com
> Cc: linux-tegra at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: linux-usb at vger.kernel.org
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> This patch is part of a series with strong internal depdendencies. I'm
> looking for an ack so that I can take the entire series through the Tegra
> and arm-soc trees. The series will be part of a stable branch that can be
> merged into other subsystems if needed to avoid/resolve dependencies.

Acked-by: Alan Stern <stern@rowland.harvard.edu>
