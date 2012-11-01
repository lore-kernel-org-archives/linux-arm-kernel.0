From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 1 Nov 2012 16:35:29 +0100
Subject: [PATCH v5] pwm: vt8500: Update vt8500 PWM driver support
In-Reply-To: <1351302597-4167-1-git-send-email-linux@prisktech.co.nz>
References: <1351302597-4167-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <20121101153525.GA16193@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 27, 2012 at 02:49:57PM +1300, Tony Prisk wrote:
> This patch updates pwm-vt8500.c to support devicetree probing and
> make use of the common clock subsystem.
> 
> A binding document describing the PWM controller found on
> arch-vt8500 is also included.
> 
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> ---
> v4:
> return err from clk_enable rather than -EBUSY
> v5:
> replace IS_ERR_OR_NULL with IS_ERR as pointed out by Chris Brand
> 
>  .../devicetree/bindings/pwm/vt8500-pwm.txt         |   17 ++++
>  drivers/pwm/pwm-vt8500.c                           |   86 ++++++++++++++------
>  2 files changed, 80 insertions(+), 23 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pwm/vt8500-pwm.txt

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121101/df148230/attachment.sig>
