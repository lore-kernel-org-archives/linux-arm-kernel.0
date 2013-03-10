From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Sun, 10 Mar 2013 23:39:36 +0100
Subject: [PATCH V2 2/5] ARM: DT: tegra114: Add i2c controller DT entry
In-Reply-To: <1362852678-13421-3-git-send-email-ldewangan@nvidia.com>
References: <1362852678-13421-1-git-send-email-ldewangan@nvidia.com>
 <1362852678-13421-3-git-send-email-ldewangan@nvidia.com>
Message-ID: <20130310223936.GF4743@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 09, 2013 at 11:41:15PM +0530, Laxman Dewangan wrote:
> NVIDIA's Tegra114 has 5 i2c controllers. These controllers have
> additional feature/configurations to make it functional over
> Tegra30's i2c controller driver.
> 
> Add DT entry for i2c controllers and make it compatible with
> "nvidia,tegra114-i2c".

Both the subject and description should probably use I2C instead of i2c.
Also I don't understand what "make it functional over" means. Perhaps,
since the entries aren't marked compatible with nvidia,tegra30-i2c you
meant to say that they are incompatible with Tegra30?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130310/9e1e6f34/attachment.sig>
