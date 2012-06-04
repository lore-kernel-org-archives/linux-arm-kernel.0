From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 04 Jun 2012 11:46:11 -0600
Subject: [PATCH V2 1/3] ARM: tegra: trimslice: enable PCIe when booting
 from device tree
In-Reply-To: <1337289674-18581-1-git-send-email-swarren@wwwdotorg.org>
References: <1337289674-18581-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <4FCCF463.3000108@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/17/2012 03:21 PM, Stephen Warren wrote:
> There currently aren't bindings for the Tegra PCIe controller. Work on
> this is in progress, but not yet complete. Manually initialize PCIe when
> booting from device tree, in order to bring DT support to the same
> feature level as board files, which will in turn allow board files to be
> deprecated.
> 
> PCIe hosts the wired Ethernet controller on TrimSlice.
> 
> To support this, add infra-structure to board-dt-tegra20.c for board-
> specific initialization code. Once device tree support for the relevant
> features is in place, this code will be removed.

Applied for 3.6 (the series).
