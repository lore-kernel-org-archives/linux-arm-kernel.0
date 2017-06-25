From: oss@buserror.net (Scott Wood)
Date: Sat, 24 Jun 2017 21:46:38 -0500
Subject: [v3] drivers:soc:fsl:qbman:qman.c: Sleep instead of stuck
 hacking jiffies.
In-Reply-To: <1493963118-11064-1-git-send-email-karim.eshapa@gmail.com>
References: <1493963118-11064-1-git-send-email-karim.eshapa@gmail.com>
Message-ID: <20170625024638.t6awgp7omzq5dcnk@home.buserror.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 05, 2017 at 07:45:18AM +0200, Karim Eshapa wrote:
> Use msleep() instead of stucking with
> long delay will be more efficient.
> 
> Signed-off-by: Karim Eshapa <karim.eshapa@gmail.com>
> ---
>  drivers/soc/fsl/qbman/qman.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)

Acked-by: Scott Wood <oss@buserror.net>

(though the subject line should be "soc/qman: ...")

Leo, are you going to send this patch (and other qman patches) via
arm-soc?

-Scott
