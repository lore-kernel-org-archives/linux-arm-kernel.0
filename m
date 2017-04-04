From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 4 Apr 2017 15:41:52 +0200
Subject: [PATCH V3 1/6] ARM: tegra: Remove unnecessary inclusion of
 flowctrl header
In-Reply-To: <1490704978-22906-2-git-send-email-jonathanh@nvidia.com>
References: <1490704978-22906-1-git-send-email-jonathanh@nvidia.com>
 <1490704978-22906-2-git-send-email-jonathanh@nvidia.com>
Message-ID: <20170404134152.GD843@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 28, 2017 at 01:42:53PM +0100, Jon Hunter wrote:
> The Tegra flowctrl.h header is included unnecessarily by the Tegra
> sleep.S source file. Remove this unnecessary inclusion.
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  arch/arm/mach-tegra/sleep.S | 2 --
>  1 file changed, 2 deletions(-)

Applied to for-4.12/arm/soc, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170404/6bddf167/attachment.sig>
