From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 29 Jul 2013 13:45:32 +0200
Subject: [PATCH v4 16/20] pwm: Remove superseded pwm-samsung-legacy driver
In-Reply-To: <1374278673-25615-18-git-send-email-tomasz.figa@gmail.com>
References: <1374278673-25615-1-git-send-email-tomasz.figa@gmail.com>
 <1374278673-25615-18-git-send-email-tomasz.figa@gmail.com>
Message-ID: <20130729114531.GD23152@manwe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 20, 2013 at 02:04:29AM +0200, Tomasz Figa wrote:
> This patch removes the now unused pwm-samsung-legacy driver, which was
> replaced by new pwm-samsung driver.
> 
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> ---
>  drivers/pwm/Makefile             |   1 -
>  drivers/pwm/pwm-samsung-legacy.c | 353 ---------------------------------------
>  2 files changed, 354 deletions(-)
>  delete mode 100644 drivers/pwm/pwm-samsung-legacy.c

Acked-by: Thierry Reding <thierry.reding@gmail.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130729/74f9e49b/attachment.sig>
