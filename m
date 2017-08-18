From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 18 Aug 2017 17:36:03 +0200
Subject: [PATCH v3 3/7] pwm: rockchip: Use pwm_apply instead of the
 pwm_enable
In-Reply-To: <1502206715-24174-4-git-send-email-david.wu@rock-chips.com>
References: <1502206715-24174-1-git-send-email-david.wu@rock-chips.com>
 <1502206715-24174-4-git-send-email-david.wu@rock-chips.com>
Message-ID: <20170818153603.GD18307@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 08, 2017 at 11:38:31PM +0800, David Wu wrote:
> Drop the custom hook of pwm_enable and implement
> pwm_apply_v1 and pwm_apply_v2 instead.
> 
> Signed-off-by: David Wu <david.wu@rock-chips.com>
> ---
>  drivers/pwm/pwm-rockchip.c | 141 +++++++++++++++++++++++++--------------------
>  1 file changed, 77 insertions(+), 64 deletions(-)

Applied to for-4.14/drivers, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170818/f5025f17/attachment.sig>
