From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 5 Sep 2016 12:36:34 +0200
Subject: [PATCH v4 09/17] pwm: sti: Only request clock rate when you need
 to
In-Reply-To: <20160816093508.28307-10-lee.jones@linaro.org>
References: <20160816093508.28307-1-lee.jones@linaro.org>
 <20160816093508.28307-10-lee.jones@linaro.org>
Message-ID: <20160905103634.GI31424@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2016 at 10:35:00AM +0100, Lee Jones wrote:
> In the original code the clock rate was only obtained during
> initialisation; however, the rate may change between then and
> its use.  This patch ensures the correct rate is acquired just
> before use.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/pwm/pwm-sti.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160905/98bb64f8/attachment.sig>
