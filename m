From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 30 Jan 2014 15:17:51 +0100
Subject: [RFC PATCH V3 0/4] APM X-Gene PCIe controller
In-Reply-To: <1390599168-13150-1-git-send-email-tinamdar@apm.com>
References: <1390599168-13150-1-git-send-email-tinamdar@apm.com>
Message-ID: <201401301517.51352.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 24 January 2014, Tanmay Inamdar wrote:
> This patch adds support for AppliedMicro X-Gene PCIe host controller. The
> driver is tested on X-Gene platform with different gen1/2/3 PCIe endpoint
> cards.
> 
> X-Gene PCIe controller driver has depedency on the pcie arch support for
> arm64. The arm64 pcie arch support is not yet part of mainline Linux kernel
> and approach for arch support is under discussion with arm64 maintainers.
> The reference patch can be found here --> https://lkml.org/lkml/2013/10/23/244
> 
> If someone wishes to test PCIe on X-Gene, arch support patch must be applied
> before the patches in this patch set.

This is starting to look really good now. I have a few small comments left,
otherwise it can get merged. As mentioned in one of my review comments, it
would be good to have the arch support patch posted along with the driver.

	Arnd
