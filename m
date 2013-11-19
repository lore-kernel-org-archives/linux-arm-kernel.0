From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Tue, 19 Nov 2013 15:24:27 -0800
Subject: [PATCH 27/31] USB: EHCI: tegra: use reset framework
In-Reply-To: <1384548866-13141-28-git-send-email-swarren@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-28-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20131119232427.GD24947@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 15, 2013 at 01:54:22PM -0700, Stephen Warren wrote:
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

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
