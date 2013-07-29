From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 29 Jul 2013 13:44:38 +0200
Subject: [PATCH v4 12/20] pwm: samsung: Rename to pwm-samsung-legacy
In-Reply-To: <1374278673-25615-14-git-send-email-tomasz.figa@gmail.com>
References: <1374278673-25615-1-git-send-email-tomasz.figa@gmail.com>
 <1374278673-25615-14-git-send-email-tomasz.figa@gmail.com>
Message-ID: <20130729114437.GB23152@manwe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 20, 2013 at 02:04:25AM +0200, Tomasz Figa wrote:
> This patch renames the old pwm-samsung driver to pwm-samsung-legacy to
> create place for the new, rewritten, DT-aware pwm-samsung driver using
> Samsung PWM/timer master driver.
> 
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> ---
>  drivers/pwm/Makefile                                | 2 +-
>  drivers/pwm/{pwm-samsung.c => pwm-samsung-legacy.c} | 0
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename drivers/pwm/{pwm-samsung.c => pwm-samsung-legacy.c} (100%)

Acked-by: Thierry Reding <thierry.reding@gmail.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130729/b9cc565c/attachment-0001.sig>
