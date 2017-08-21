From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 21 Aug 2017 08:12:34 +0200
Subject: [PATCH 1/4] pwm: pwm-tiecap: Add TI 66AK2G SoC specific compatible
In-Reply-To: <20170807114943.22612-2-vigneshr@ti.com>
References: <20170807114943.22612-1-vigneshr@ti.com>
 <20170807114943.22612-2-vigneshr@ti.com>
Message-ID: <20170821061234.GF18996@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 07, 2017 at 05:19:40PM +0530, Vignesh R wrote:
> Add a new compatible string "ti,k2g-ecap" to support PWM ECAP IP of
> TI 66AK2G SoC.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-tiecap.txt | 1 +
>  1 file changed, 1 insertion(+)

Applied to for-4.14/drivers, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170821/29b876ec/attachment.sig>
