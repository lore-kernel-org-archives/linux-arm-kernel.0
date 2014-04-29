From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 29 Apr 2014 16:24:32 +0200
Subject: [PATCH] ARM: tegra: add SD wp-gpios to Dalmore DT
In-Reply-To: <1398711106-22484-1-git-send-email-swarren@wwwdotorg.org>
References: <1398711106-22484-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20140429142431.GC23699@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 12:51:46PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Dalmore can detect write-protect on the SD card. Add the required
> DT entries to allow this.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  arch/arm/boot/dts/tegra114-dalmore.dts | 1 +
>  1 file changed, 1 insertion(+)

This one I can't test, since my A05 Dalmore has a micro SD card which I
don't think can be write-protected.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140429/189cd6ca/attachment.sig>
