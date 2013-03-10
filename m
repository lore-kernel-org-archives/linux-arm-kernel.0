From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Sun, 10 Mar 2013 23:51:17 +0100
Subject: [PATCH V2 5/5] ARM: DT: tegra114: Add spi controller DT entry
In-Reply-To: <1362852678-13421-6-git-send-email-ldewangan@nvidia.com>
References: <1362852678-13421-1-git-send-email-ldewangan@nvidia.com>
 <1362852678-13421-6-git-send-email-ldewangan@nvidia.com>
Message-ID: <20130310225117.GI4743@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 09, 2013 at 11:41:18PM +0530, Laxman Dewangan wrote:
> NVIDIA's Tegra114 has 6 spi controllers. These controllers are
> redesign on T114 with different register interface.
> 
> Add DT entry for spi controllers and make it compatible with
> "nvidia,tegra114-spi".

Similarly, SPI is an abbreviation and should be in all uppercase
letters. I can't really comment on the rest since there's no TRM
available publicly to check against.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130310/7af363f9/attachment-0001.sig>
