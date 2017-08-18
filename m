From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 18 Aug 2017 17:43:44 +0200
Subject: [PATCH v3 5/7] pwm: rockchip: Use same pwm ops for each IP
In-Reply-To: <1502206888-24302-1-git-send-email-david.wu@rock-chips.com>
References: <1502206715-24174-1-git-send-email-david.wu@rock-chips.com>
 <1502206888-24302-1-git-send-email-david.wu@rock-chips.com>
Message-ID: <20170818154344.GF18307@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 08, 2017 at 11:41:28PM +0800, David Wu wrote:
> Just use the same pwm ops for each IP, and get rid of the
> ops in the struct of rockchip_pwm_data, but still define
> the 3 different rockchip_pwm_data to use common interface
> for each IP.
> 
> Signed-off-by: David Wu <david.wu@rock-chips.com>
> ---
>  drivers/pwm/pwm-rockchip.c | 147 ++++++++++++---------------------------------
>  1 file changed, 38 insertions(+), 109 deletions(-)

Applied to for-4.14/drivers, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170818/323ecfc9/attachment-0001.sig>
