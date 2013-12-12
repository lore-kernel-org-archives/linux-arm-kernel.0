From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 12 Dec 2013 13:37:30 +0100
Subject: [PATCH 11/15] pwm: pwm-renesas-tpu: Enable driver compilation
 with COMPILE_TEST
In-Reply-To: <1385515117-23664-12-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1385515117-23664-12-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <20131212123728.GJ11524@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 27, 2013 at 02:18:33AM +0100, Laurent Pinchart wrote:
> This helps increasing build testing coverage.
> 
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: linux-pwm at vger.kernel.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Acked-by: Simon Horman <horms@verge.net.au>
> ---
>  drivers/pwm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131212/221115d9/attachment.sig>
