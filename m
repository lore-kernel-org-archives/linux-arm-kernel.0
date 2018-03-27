From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 28 Mar 2018 01:09:15 +0200
Subject: [PATCH] pwm: sun4i: properly check current state
In-Reply-To: <20180225015558.4843-1-alexandre.belloni@bootlin.com>
References: <20180225015558.4843-1-alexandre.belloni@bootlin.com>
Message-ID: <20180327230914.GA4097@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 25, 2018 at 02:55:58AM +0100, Alexandre Belloni wrote:
> Correctly extract the prescaler value from CTRL_REG before comparing it to
> PWM_PRESCAL_MASK.
> 
> Also, check that both PWM_CLK_GATING and PWM_EN to ensure the PWM is
> enabled instead of relying on only one of those.
> 
> Fixes: 93e0dfb2c52f ("pwm: sun4i: Improve hardware read out")
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/pwm/pwm-sun4i.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180328/1ff93111/attachment.sig>
