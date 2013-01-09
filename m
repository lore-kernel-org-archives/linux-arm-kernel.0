From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 9 Jan 2013 08:47:27 +0100
Subject: [PATCHv2 2/2] pwm: vt8500: Add polarity support
In-Reply-To: <1357155856-9552-2-git-send-email-linux@prisktech.co.nz>
References: <1357155856-9552-1-git-send-email-linux@prisktech.co.nz>
 <1357155856-9552-2-git-send-email-linux@prisktech.co.nz>
Message-ID: <20130109074727.GD12782@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 03, 2013 at 08:44:16AM +1300, Tony Prisk wrote:
> Add support to set polarity on PWM devices, allowing for inverted
> duty cycles.
> 
> Also update the binding document to #pwm-cells = <3> to allow
> passing the flags from devicetree.
> 
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> ---
> v2:
> Change binding document to detail flags usage.
> Add missing .of_xlate function
> Add missing .of_pwm_n_cells
> 
>  .../devicetree/bindings/pwm/vt8500-pwm.txt         |    9 +++++---
>  drivers/pwm/pwm-vt8500.c                           |   23 ++++++++++++++++++++
>  2 files changed, 29 insertions(+), 3 deletions(-)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130109/a1e301cd/attachment.sig>
