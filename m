From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 25 Jul 2017 13:44:12 +0200
Subject: [PATCH v1] pwm : pwm-vt8500 - Undo preparation of a clock source.
In-Reply-To: <1493971214-3763-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1493971214-3763-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <20170725114412.GC22355@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 05, 2017 at 01:30:14PM +0530, Arvind Yadav wrote:
> Undo preparation of a clock source, if vt8500_pwm_probe is not
> successful.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/pwm/pwm-vt8500.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170725/841160eb/attachment.sig>
