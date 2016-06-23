From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 23 Jun 2016 10:24:36 +0200
Subject: [RESEND PATCH v2 2/5] pwm: omap-dmtimer: Allow for setting
 dmtimer clock source
In-Reply-To: <1466623341-30130-3-git-send-email-ivo.g.dimitrov.75@gmail.com>
References: <1466623341-30130-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <1466623341-30130-3-git-send-email-ivo.g.dimitrov.75@gmail.com>
Message-ID: <20160623082436.GB8136@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 22, 2016 at 10:22:18PM +0300, Ivaylo Dimitrov wrote:
> OMAP GP timers can have different input clocks that allow different PWM
> frequencies. However, there is no other way of setting the clock source but
> through clocks or clock-names properties of the timer itself. This limits
> PWM functionality to only the frequencies allowed by the particular clock
> source. Allowing setting the clock source by PWM rather than by timer
> allows different PWMs to have different ranges by not hard-wiring the clock
> source to the timer.
> 
> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-omap-dmtimer.txt |  4 ++++
>  drivers/pwm/pwm-omap-dmtimer.c                             | 12 +++++++-----
>  2 files changed, 11 insertions(+), 5 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160623/433af8bd/attachment.sig>
