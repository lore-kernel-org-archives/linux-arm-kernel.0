From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 16 Oct 2018 13:15:41 +0200
Subject: [PATCH v2 0/2] pwm-tiecap: Add support for AM654 SoCs
In-Reply-To: <20181016060402.18756-1-vigneshr@ti.com>
References: <20181016060402.18756-1-vigneshr@ti.com>
Message-ID: <20181016111541.GE8852@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 16, 2018 at 11:34:00AM +0530, Vignesh R wrote:
> Couple of patches to enable pwm-tiecap driver to be used with TI's new
> AM654 platforms.
> 
> Vignesh R (2):
>   dt-bindings: pwm: tiecap: Add TI AM654 SoC specific compatible
>   pwm: Kconfig: Enable TI ECAP driver for ARCH_K3
> 
>  Documentation/devicetree/bindings/pwm/pwm-tiecap.txt | 1 +
>  drivers/pwm/Kconfig                                  | 5 ++---
>  2 files changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181016/40478ac7/attachment.sig>
