From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 20 Aug 2018 11:31:06 +0200
Subject: [PATCH] pwm: stm32-lp: Remove useless loop in
 stm32_pwm_lp_remove()
In-Reply-To: <1532070992-16831-1-git-send-email-fabrice.gasnier@st.com>
References: <1532070992-16831-1-git-send-email-fabrice.gasnier@st.com>
Message-ID: <20180820093106.GB8242@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 20, 2018 at 09:16:32AM +0200, Fabrice Gasnier wrote:
> LPTimer has only one pwm channel (npwm = 1). Remove useless for loop
> in remove routine.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  drivers/pwm/pwm-stm32-lp.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180820/0b2deee1/attachment.sig>
