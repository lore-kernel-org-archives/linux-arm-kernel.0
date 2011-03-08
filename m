From: olof@lixom.net (Olof Johansson)
Date: Tue, 8 Mar 2011 10:06:28 -0800
Subject: [PATCH 0/3] Harmony PCI-e and regulators
In-Reply-To: <cover.1299588456.git.mike@compulab.co.il>
References: <cover.1299588456.git.mike@compulab.co.il>
Message-ID: <AANLkTikZhz93EEjGov7MDa7tedMNvf05YavQD1ny2H8F@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Mar 8, 2011 at 4:58 AM, Mike Rapoport <mike@compulab.co.il> wrote:
> These patches provide update for Harmony PCI-e intialization and add
> registration of the TPS65862 PMIC.
> Additionally, there are several tegra_defconfig updates. These updates
> allow booting the Harmony with PCI-e enabled and add ability to boot
> TrimSlice with root on NFS.
>
> The patches were generated vs. Olof's board-for-next-i2c that seems to
> disappear. If there are now objection to these patches I can push them
> into separate branch in my tree, so that it can be pulled after Tegra
> I2C is merged.

Given the discussion yesterday, I merged what was essentially in the
-i2c branch into the regular boards-for-next branch. I can take these
through the same branch, since Colin hasn't pulled yet.


-Olof
