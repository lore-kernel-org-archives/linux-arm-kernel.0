From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 10 May 2012 11:18:15 -0700
Subject: [PATCH 1/4] ARM: tegra20: Add Tegra Memory Controller(MC) driver
In-Reply-To: <4FABF9AB.6020902@wwwdotorg.org>
References: <1336635764-30597-1-git-send-email-hdoyu@nvidia.com>
 <4FABF9AB.6020902@wwwdotorg.org>
Message-ID: <20120510181815.GA17018@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2012 at 11:23:55AM -0600, Stephen Warren wrote:
> On 05/10/2012 01:42 AM, Hiroshi DOYU wrote:
> > Tegra Memory Controller(MC) driver for Tegra20
> > Added to support MC General interrupts, mainly for IOMMU(GART).
> 
> Greg, you appear to have been commiting all of drivers/memory. I assume
> you'll take patches 1 and 3 in this series, and I will take 2 and 4
> through the Tegra tree? I can take them all through the Tegra tree if
> you want.

I think you will get a conflict if you take the memory ones in your
tree, so I will take those two, thanks.

greg k-h
