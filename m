From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 29 Apr 2014 16:21:55 +0200
Subject: [PATCH] ARM: tegra: add SD wp-gpios to Jetson TK1 DT
In-Reply-To: <1398704846-18262-1-git-send-email-swarren@wwwdotorg.org>
References: <1398704846-18262-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20140429142153.GB23699@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 11:07:26AM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Jetson TK1 can detect write-protect on the SD card. Add the required
> DT entries to allow this.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  arch/arm/boot/dts/tegra124-jetson-tk1.dts | 1 +
>  1 file changed, 1 insertion(+)

Tested-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140429/481fcadb/attachment.sig>
