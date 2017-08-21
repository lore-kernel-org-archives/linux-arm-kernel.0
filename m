From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 21 Aug 2017 09:35:16 +0200
Subject: [PATCH v3  2/6] pwm: mediatek: fix pwm source clock selection
In-Reply-To: <1498802721-32455-3-git-send-email-zhi.mao@mediatek.com>
References: <1498802721-32455-1-git-send-email-zhi.mao@mediatek.com>
 <1498802721-32455-3-git-send-email-zhi.mao@mediatek.com>
Message-ID: <20170821073516.GL18996@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 30, 2017 at 02:05:17PM +0800, Zhi Mao wrote:
> In original code, the pwm output frequency is not correct
> when set bit<3>=1 to PWMCON register.
> 
> Signed-off-by: Zhi Mao <zhi.mao@mediatek.com>
> ---
>  drivers/pwm/pwm-mediatek.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-4.14/drivers, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170821/085d50f4/attachment.sig>
