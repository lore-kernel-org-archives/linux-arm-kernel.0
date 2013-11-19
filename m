From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Tue, 19 Nov 2013 15:23:35 -0800
Subject: [PATCH 21/31] staging: nvec: use reset framework
In-Reply-To: <1384548866-13141-22-git-send-email-swarren@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-22-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20131119232335.GA24947@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 15, 2013 at 01:54:16PM -0700, Stephen Warren wrote:
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
> Cc: Julian Andres Klode <jak@jak-linux.org>
> Cc: Marc Dietrich <marvin24@gmx.de>
> Cc: ac100 at lists.launchpad.net
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: devel at driverdev.osuosl.org
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> This patch is part of a series with strong internal depdendencies. I'm
> looking for an ack so that I can take the entire series through the Tegra
> and arm-soc trees. The series will be part of a stable branch that can be
> merged into other subsystems if needed to avoid/resolve dependencies.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
