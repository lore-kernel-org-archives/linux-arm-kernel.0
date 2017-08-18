From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 18 Aug 2017 17:40:21 +0200
Subject: [PATCH v3 4/7] pwm: rockchip: Move the configuration of polarity
 from rockchip_pwm_set_enable() to rockchip_pwm_config()
In-Reply-To: <1502206715-24174-5-git-send-email-david.wu@rock-chips.com>
References: <1502206715-24174-1-git-send-email-david.wu@rock-chips.com>
 <1502206715-24174-5-git-send-email-david.wu@rock-chips.com>
Message-ID: <20170818154021.GE18307@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 08, 2017 at 11:38:32PM +0800, David Wu wrote:
> It is usually possible to configure the polarity, cycle and duty all at once,
> so that the polarity and cycle and duty should be binding together. Move it
> into rockchip_pwm_config(), as well as prepared for the next atomic update
> commit.
> 
> Signed-off-by: David Wu <david.wu@rock-chips.com>
> ---
>  drivers/pwm/pwm-rockchip.c | 48 +++++++++++++++++++++++-----------------------
>  1 file changed, 24 insertions(+), 24 deletions(-)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170818/4a1b08a6/attachment.sig>
