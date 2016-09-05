From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 5 Sep 2016 12:53:17 +0200
Subject: [PATCH v4 13/17] pwm: sti: Add support for PWM Capture IRQs
In-Reply-To: <20160816093508.28307-14-lee.jones@linaro.org>
References: <20160816093508.28307-1-lee.jones@linaro.org>
 <20160816093508.28307-14-lee.jones@linaro.org>
Message-ID: <20160905105317.GM31424@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2016 at 10:35:04AM +0100, Lee Jones wrote:
> Here we're requesting the PWM Capture IRQ and supplying the
> handler which will be called in the event of an IRQ fire to
> handle it.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/pwm/pwm-sti.c | 92 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 91 insertions(+), 1 deletion(-)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160905/da4046a8/attachment.sig>
