From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 21 Aug 2017 08:05:54 +0200
Subject: [PATCH] pwm: Kconfig: Enable pwm-tiecap to be built for Keystone
In-Reply-To: <20170802061344.1713-1-vigneshr@ti.com>
References: <20170802061344.1713-1-vigneshr@ti.com>
Message-ID: <20170821060554.GD18996@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 02, 2017 at 11:43:44AM +0530, Vignesh R wrote:
> 66AK2G SoC has ECAP subsystem that is used as pwm-backlight provider for
> display. Hence, enable pwm-tiecap driver to be built for Keystone
> architecture.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  drivers/pwm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-4.14/drivers, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170821/16927fe5/attachment-0001.sig>
