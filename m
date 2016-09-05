From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 5 Sep 2016 08:36:05 +0200
Subject: [PATCH V2 2/3] pwm: Add MediaTek MT2701 display PWM driver support
In-Reply-To: <1468225089-28576-3-git-send-email-weiqing.kong@mediatek.com>
References: <1468225089-28576-1-git-send-email-weiqing.kong@mediatek.com>
 <1468225089-28576-3-git-send-email-weiqing.kong@mediatek.com>
Message-ID: <20160905063605.GC3532@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2016 at 04:18:08PM +0800, Weiqing Kong wrote:
> Use the mtk_pwm_data struction to define different registers
> and add MT2701 specific register operations, such as MT2701
> doesn't have commit register, needs to disable double buffer
> before writing register, and needs to select manual mode
> and use PWM_PERIOD/PWM_HIGH_WIDTH.
> 
> Signed-off-by: Weiqing Kong <weiqing.kong@mediatek.com>
> ---
>  drivers/pwm/pwm-mtk-disp.c | 99 +++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 80 insertions(+), 19 deletions(-)

Applied. This had a few inconsistencies in how things were parameterized
and I fixed those up. Please check that everything still works as
expected.

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160905/34acc7e4/attachment.sig>
