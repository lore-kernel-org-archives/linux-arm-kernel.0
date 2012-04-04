From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 4 Apr 2012 07:49:38 +0200
Subject: [PATCH RESEND] pwm: add pwm-mxs support
In-Reply-To: <1333507852-8509-1-git-send-email-shawn.guo@linaro.org>
References: <1333506822-8349-1-git-send-email-shawn.guo@linaro.org>
 <1333507852-8509-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120404054938.GB10543@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Shawn Guo wrote:
> Add generic PWM framework driver (DT only) for Freescale MXS.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
> 
> Resend to add binding document.
> 
>  Documentation/devicetree/bindings/pwm/mxs-pwm.txt |   17 ++
>  drivers/pwm/Kconfig                               |    9 +
>  drivers/pwm/Makefile                              |    1 +
>  drivers/pwm/pwm-mxs.c                             |  207 +++++++++++++++++++++
>  4 files changed, 234 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pwm/mxs-pwm.txt
>  create mode 100644 drivers/pwm/pwm-mxs.c

This looks great. I'll take it into the next round. I'm still waiting for one
comment from Stephen Warren but otherwise I should have v6 ready before the
weekend.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120404/9327a3b0/attachment.sig>
