From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 21 May 2014 12:26:18 +0200
Subject: [PATCH] pwm: atmel: set pwm_chip can_sleep flag
In-Reply-To: <1397067969-19905-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1397067969-19905-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20140521102617.GD22783@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 09, 2014 at 08:26:09PM +0200, Alexandre Belloni wrote:
> atmel_pwm_config() calls clk_get_rate() which might sleep, so we need to set
> pwm_chip can_sleep flag.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  drivers/pwm/pwm-atmel.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140521/4e98ad5a/attachment.sig>
