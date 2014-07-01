From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 1 Jul 2014 09:15:45 +0300
Subject: [PATCH] video: fbdev: s3c2410fb: Move to
 clk_prepare_enable/clk_disable_unprepare
In-Reply-To: <1404155672-3158-1-git-send-email-anarsoul@gmail.com>
References: <1404155672-3158-1-git-send-email-anarsoul@gmail.com>
Message-ID: <53B25211.1000600@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/06/14 22:14, Vasily Khoruzhick wrote:
> Use clk_prepare_enable/clk_disable_unprepare to make the driver
> work properly with common clock framework.
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  drivers/video/fbdev/s3c2410fb.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Thanks, queued for 3.17.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140701/500eafb6/attachment.sig>
