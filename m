From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 29 Jul 2013 13:44:52 +0200
Subject: [PATCH v4 13/20] pwm: Add new pwm-samsung driver
In-Reply-To: <1374278673-25615-15-git-send-email-tomasz.figa@gmail.com>
References: <1374278673-25615-1-git-send-email-tomasz.figa@gmail.com>
 <1374278673-25615-15-git-send-email-tomasz.figa@gmail.com>
Message-ID: <20130729114452.GC23152@manwe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 20, 2013 at 02:04:26AM +0200, Tomasz Figa wrote:
> This patch introduces new Samsung PWM driver, which uses Samsung
> PWM/timer master driver to control shared parts of the hardware.
> 
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> ---
>  drivers/pwm/Makefile      |   1 +
>  drivers/pwm/pwm-samsung.c | 606 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 607 insertions(+)
>  create mode 100644 drivers/pwm/pwm-samsung.c

Acked-by: Thierry Reding <thierry.reding@gmail.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130729/87153f83/attachment.sig>
