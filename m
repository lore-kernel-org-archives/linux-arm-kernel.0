From: olof@lixom.net (Olof Johansson)
Date: Sun, 18 Mar 2012 10:31:59 -0700
Subject: [PATCH 00/11] ARM: tegra: Add PCIe device tree support
In-Reply-To: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
References: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <20120318173159.GB24110@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 08, 2012 at 03:51:20PM +0100, Thierry Reding wrote:
> This patch series adds support for device tree based probing of the PCIe
> controller found on Tegra SoCs.
> 
> Patches 1 and 2 have already been posted by Grant and Mark respectively
> but I've included them here for reference. Both patches are dependencies
> for the subsequent patches.
> 
> Patches 3, 4 and 5 add support for obtaining the regulators required to
> power the PCIe controller from the device tree. Patches 6 and 7 are
> required to make some common PCI functions available after the init
> phase because the deferred probing will postpone the probing of the PCIe
> controller driver until that point.
> 
> Patches 8 and 9 make the PCIe controller code available as a driver and
> add the corresponding platform devices to the boards that enable PCIe
> (Harmony and TrimSlice). Patch 10 adds MSI support and patch 11 finally
> adds a device tree binding with documentation.
> 
> The code in patch 10 (MSI support) is based on the Vibrante kernel and I
> wasn't able to get a proper Signed-off-by or even copyright information.
> Perhaps somebody at NVIDIA can find out?

Hi,

This patch series looks good to me, but I'm out of time to stage it for
3.4. Stephen is taking over lead maintainership for 3.5 and forward,
so I'll let him pick it up for that release.


-Olof
