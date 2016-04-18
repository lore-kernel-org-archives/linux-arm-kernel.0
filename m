From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 18 Apr 2016 09:05:29 +0200
Subject: [RESEND PATCH] drm/panel: simple-panel: set appropriate mode type
In-Reply-To: <1460737413-29799-1-git-send-email-nicolas.ferre@atmel.com>
References: <1430404770-29704-1-git-send-email-boris.brezillon@free-electrons.com>
 <1460737413-29799-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20160418070529.GA15946@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 15, 2016 at 06:23:33PM +0200, Nicolas Ferre wrote:
> From: Boris Brezillon <boris.brezillon@free-electrons.com>
> 
> All modes exposed by simple panels should be tagged as driver defined
> modes.
> Moreover, if a panel supports only one mode, this mode is obviously the
> preferred one.
> 
> Doing this also fix a problem occurring when a 'video=' parameter is passed
> on the kernel cmdline. In some cases the user provided mode is preferred
> over the simple panel ones, which might result in unpredictable behavior.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Reviewed-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Tested-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  drivers/gpu/drm/panel/panel-simple.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160418/71ce3ea8/attachment.sig>
