From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 20 Dec 2013 10:50:29 +0100
Subject: [PATCH] pwm: atmel-pwm: clock can not unprepare after
 successfully register
In-Reply-To: <1387424542-5864-1-git-send-email-voice.shen@atmel.com>
References: <1387424542-5864-1-git-send-email-voice.shen@atmel.com>
Message-ID: <20131220095028.GE27787@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 19, 2013 at 11:42:22AM +0800, Bo Shen wrote:
> When the PWM controller is registered successfully, the clock can not
> unprepare, so fix it.
> 
> Signed-off-by: Bo Shen <voice.shen@atmel.com>
> ---
>  drivers/pwm/pwm-atmel.c |    2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131220/cd8e0c63/attachment.sig>
