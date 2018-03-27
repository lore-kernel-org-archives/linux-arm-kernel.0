From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 27 Mar 2018 23:29:34 +0200
Subject: [PATCH] pwm: atmel-tcb: Delete an error message for a failed
 memory allocation in atmel_tcb_pwm_probe()
In-Reply-To: <8274c498-1d1b-2ece-365c-98ded714a53c@users.sourceforge.net>
References: <8274c498-1d1b-2ece-365c-98ded714a53c@users.sourceforge.net>
Message-ID: <20180327212933.GC28058@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 15, 2017 at 07:00:46PM +0100, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 15 Dec 2017 18:55:11 +0100
> 
> Omit an extra message for a memory allocation failure in this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/pwm/pwm-atmel-tcb.c | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180327/4356c3b4/attachment.sig>
