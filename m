From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 30 Jan 2013 09:15:21 +0100
Subject: [PATCH v3 2/3] pwm: Add can_sleep property to drivers
In-Reply-To: <1359381659-24454-3-git-send-email-florian.vaussard@epfl.ch>
References: <1359381659-24454-1-git-send-email-florian.vaussard@epfl.ch>
 <1359381659-24454-3-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <20130130081521.GB13568@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 28, 2013 at 03:00:58PM +0100, Florian Vaussard wrote:
> Calls to PWM drivers connected through I2C can sleep.
> Use the new can_sleep property.
> 
> Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
> ---
>  drivers/pwm/pwm-twl-led.c |    1 +
>  drivers/pwm/pwm-twl.c     |    1 +
>  2 files changed, 2 insertions(+), 0 deletions(-)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130130/a2d8738d/attachment.sig>
