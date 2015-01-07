From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 7 Jan 2015 16:18:47 +0100
Subject: [PATCH] ARM: tegra: Regenerate defconfig based on v3.19-rc1
In-Reply-To: <1420550407-4059-1-git-send-email-thierry.reding@gmail.com>
References: <1420550407-4059-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <20150107151843.GA2912@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 06, 2015 at 02:20:07PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Removes the following entries from the default configuration:
> 
> - PM: enabled by default (via PM_SLEEP -> SUSPEND)
> - RESOURCE_COUNTERS: removed
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> I intend to apply this to the for-3.20/defconfig branch if nobody
> objects.
> 
>  arch/arm/configs/tegra_defconfig | 2 --
>  1 file changed, 2 deletions(-)

I've applied this to the for-3.20/defconfig branch.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150107/1df81029/attachment.sig>
