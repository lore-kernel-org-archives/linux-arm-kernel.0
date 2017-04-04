From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 4 Apr 2017 16:01:21 +0200
Subject: [PATCH V3 3/6] soc/tegra: flowctrl: Add basic platform driver
In-Reply-To: <1490704978-22906-4-git-send-email-jonathanh@nvidia.com>
References: <1490704978-22906-1-git-send-email-jonathanh@nvidia.com>
 <1490704978-22906-4-git-send-email-jonathanh@nvidia.com>
Message-ID: <20170404140121.GF843@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 28, 2017 at 01:42:55PM +0100, Jon Hunter wrote:
> Add a simple platform driver for the flowctrl module so that it gets
> registered as a proper device.
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/soc/tegra/flowctrl.c | 34 ++++++++++++++++++++++++++++++----
>  1 file changed, 30 insertions(+), 4 deletions(-)

Applied to for-4.12/soc, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170404/063c4e9a/attachment-0001.sig>
