From: olof@lixom.net (Olof Johansson)
Date: Wed, 7 Dec 2011 16:20:18 -0800
Subject: [PATCH 2/5] arm/dt: tegra: Remove /chosen node
In-Reply-To: <1321911851-10091-2-git-send-email-swarren@nvidia.com>
References: <1321911851-10091-1-git-send-email-swarren@nvidia.com>
 <1321911851-10091-2-git-send-email-swarren@nvidia.com>
Message-ID: <20111208002018.GH12945@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 21, 2011 at 02:44:08PM -0700, Stephen Warren wrote:
> The command-lines present in the existing /chosen node are not necessarily
> correct for all users. Ideally, we should simply use the command-line
> supplied by the boot-loader.
> 
> In fact, using the boot-loader's cmdline is quite easy; either the
> bootloader fully supports DT, in which case it can modify the DT passed
> to the kernel to include its command-line, or CONFIG_APPENDED_DTB can
> be used in conjunction with CONFIG_ARM_ATAG_DTB_COMPAT, and the kernel
> will substitute the bootloader's command-line into the DT.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Thanks, applied to for-3.3/boards

-Olof
