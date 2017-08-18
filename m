From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 18 Aug 2017 17:32:55 +0200
Subject: [PATCH v3 2/7] pwm: rockchip: Remove the judge from return value
 of pwm_config
In-Reply-To: <1502206715-24174-3-git-send-email-david.wu@rock-chips.com>
References: <1502206715-24174-1-git-send-email-david.wu@rock-chips.com>
 <1502206715-24174-3-git-send-email-david.wu@rock-chips.com>
Message-ID: <20170818153255.GC18307@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 08, 2017 at 11:38:30PM +0800, David Wu wrote:
> It seems the rockchip_pwm_config always returns the result 0,
> so remove the judge.
> 
> Signed-off-by: David Wu <david.wu@rock-chips.com>
> Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  drivers/pwm/pwm-rockchip.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)

I don't understand what the "judge" is supposed to be, but I've applied
this to for-4.14/drivers anyway. Thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170818/416eac75/attachment-0001.sig>
