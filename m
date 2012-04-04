From: olof@lixom.net (Olof Johansson)
Date: Wed, 4 Apr 2012 11:52:00 -0700
Subject: [PATCH 10/11] ARM: dt: tegra cardhu: add pinmux to device tree
In-Reply-To: <1333148404-17691-11-git-send-email-swarren@wwwdotorg.org>
References: <1333148404-17691-1-git-send-email-swarren@wwwdotorg.org>
 <1333148404-17691-11-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20120404185200.GB30926@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 30, 2012 at 05:00:03PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> This adds a minimal pinmux configuration to the Tegra Cardhu device
> tree. Initially, just the built-in eMMC and SD card slot are configured.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Looks reasonable enough. I guess you should get ack from Peter and not me on
this but anyway:

Acked-by: Olof Johansson <olof@lixom.net


-Olof
