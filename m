From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 11 Jul 2014 17:02:19 +0200
Subject: [PATCH v2 1/3] pwm: add Rockchip SoC PWM support
In-Reply-To: <1403360528-12757-2-git-send-email-b.galvani@gmail.com>
References: <1403360528-12757-1-git-send-email-b.galvani@gmail.com>
 <1403360528-12757-2-git-send-email-b.galvani@gmail.com>
Message-ID: <20140711150218.GC6523@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 21, 2014 at 04:22:06PM +0200, Beniamino Galvani wrote:
> This commit adds a driver for the PWM controller found on Rockchip
> RK29, RK30 and RK31 SoCs.
> 
> Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
> ---
>  drivers/pwm/Kconfig        |    7 ++
>  drivers/pwm/Makefile       |    1 +
>  drivers/pwm/pwm-rockchip.c |  177 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 185 insertions(+)
>  create mode 100644 drivers/pwm/pwm-rockchip.c

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140711/259f442e/attachment.sig>
