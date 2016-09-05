From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 5 Sep 2016 12:42:03 +0200
Subject: [PATCH v4 11/17] pwm: sti: Supply PWM Capture clock handling
In-Reply-To: <20160816093508.28307-12-lee.jones@linaro.org>
References: <20160816093508.28307-1-lee.jones@linaro.org>
 <20160816093508.28307-12-lee.jones@linaro.org>
Message-ID: <20160905104203.GK31424@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2016 at 10:35:02AM +0100, Lee Jones wrote:
> ST's PWM IP is supplied by 2 different clocks.  One for PWM
> Output and the other for Capture.  This patch provides clock
> handling for the latter.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/pwm/pwm-sti.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160905/b131ef64/attachment-0001.sig>
