From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 6 Apr 2017 16:14:32 +0200
Subject: [PATCH v2] pwm: atmel-hlcdc: Convert to the atomic PWM API
In-Reply-To: <1488379731-12951-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1488379731-12951-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20170406141432.GB8438@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 01, 2017 at 03:48:51PM +0100, Boris Brezillon wrote:
> Implement the ->apply() hook and drop the ->enable(), ->disable,
> ->set_polarity and ->config() ones.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> ---
> Changes from v1:
> - stop the source clk when the PWM is being disabled
> ---
>  drivers/pwm/pwm-atmel-hlcdc.c | 227 +++++++++++++++++++-----------------------
>  1 file changed, 101 insertions(+), 126 deletions(-)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170406/a031af41/attachment.sig>
