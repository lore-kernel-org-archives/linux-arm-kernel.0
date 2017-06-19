From: olof@lixom.net (Olof Johansson)
Date: Sun, 18 Jun 2017 20:56:07 -0700
Subject: [GIT PULL] arm64: dts: juno: updates for v4.13
In-Reply-To: <e2f52cbd-7c6d-6a4e-1690-aa7e27f15805@arm.com>
References: <e2f52cbd-7c6d-6a4e-1690-aa7e27f15805@arm.com>
Message-ID: <20170619035607.GB30022@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 15, 2017 at 12:34:11PM +0100, Sudeep Holla wrote:
> Hi ARM-SoC team,
> 
> Please pull!
> 
> Regards,
> Sudeep
> 
> --
> 
> The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:
> 
>   Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git
> tags/juno-updates-4.13
> 
> for you to fetch changes up to 6806f2c70cfe145b3b6809242c8e1254071c1cf3:
> 
>   arm64: dts: juno: enable some SMMUs (2017-05-19 14:38:16 +0100)
> 
> ----------------------------------------------------------------
> ARMv8 Vexpress/Juno DT updates for v4.13
> 
> 1. Adds support for Coresight CPU debug MMIO interface on all Juno variants.
> 
> 2. Enables support for few SMMUs on Juno which were previously disabled
>    waiting for IOMMU-backed DMA API support to be stabilised.

Merged, thanks.


-Olof
