From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 4 Mar 2016 16:01:06 +0100
Subject: [PATCH v2] pwm: pwm-lpc18xx-sct: test clock rate to avoid
 division by 0
In-Reply-To: <1456959443-10032-1-git-send-email-wsa@the-dreams.de>
References: <1456959443-10032-1-git-send-email-wsa@the-dreams.de>
Message-ID: <20160304150106.GA26400@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 02, 2016 at 11:57:09PM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> The clk API may return 0 on clk_get_rate, so we should check the result before
> using it as a divisor.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/pwm/pwm-lpc18xx-sct.c | 5 +++++
>  1 file changed, 5 insertions(+)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160304/f6a9192e/attachment.sig>
