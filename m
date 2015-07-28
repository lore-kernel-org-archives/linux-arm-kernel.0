From: olof@lixom.net (Olof Johansson)
Date: Tue, 28 Jul 2015 12:55:56 +0200
Subject: [PATCH v5 0/4] Add Broadcom North Star 2 support
In-Reply-To: <1438036941-27210-1-git-send-email-rjui@broadcom.com>
References: <1438036941-27210-1-git-send-email-rjui@broadcom.com>
Message-ID: <20150728105556.GA16025@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 27, 2015 at 03:42:17PM -0700, Ray Jui wrote:
> This patch series adds Broadcom North Star 2 (NS2) SoC support. NS2 is an ARMv8
> based SoC and under the Broadcom iProc family.
> 
> Sorry for tying this with the Broadcom iProc PCIe driver fixes for ARM64. I
> have to tie them together because iProc PCIe support is enabled by default
> when ARCH_BCM_IPROC is enabled. Without the fixes in the iProc PCIe driver,
> enabling CONFIG_ARCH_BCM_IPROC would break the build for arm64 defconfig. Let
> me know if there's a better way to handle this.

One common way to handle it is that instead of sitting on the patch to fix PCI
for months, you post that early such that when the rest is posted, it's been in
the kernel for a long time.

In practice, that's sometimes hard to do, but it's the ideal situation.

Anyway, I've queued up these patches for 4.3. Thanks!


-Olof
